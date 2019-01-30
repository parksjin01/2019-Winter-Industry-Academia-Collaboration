<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="recomm.RecommDAO" %>
<%@ page import="recomm.Recomm" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE HTML>
<!--
	Dimension by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>Dimension by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		
		<style media="screen">
			div.logo::before {
				opacity: 0;
			}

			#navigator {
				align: right;
				padding-right: 0;
				width: 100%;
				margin-bottom: 5em;
			}

			#navigator ul {
				display: -moz-flex;
				display: -webkit-flex;
				display: -ms-flex;
				display: flex;
				justify-content: flex-end;
				margin-bottom: 0;
				align: right;
				list-style: none;
				padding-left: 0;
				width: 100%;
				text-align: right;
				overflow: hidden;
				/* border: solid 1px #ffffff;
				border-radius: 4px; */
			}

			#navigator ul li {
				/* display: inline; */
				float:right;
			}

			#navigator ul li span {
				/* float: right; */
				display: block;

			}
			#del li {
				float: right;
				margin: 0 0.5em 0 0;
			}
			#dropzone
		    {
		        border:2px dotted #3292A2;
		        width:100%;
		        height:180px;
		        line-height:180px;
		        color:#92AAB0;
		        text-align:center;
		        font-size:24px;
		        margin:0 0 12px 0;
		    }
		</style>
		<script>

			function edit(idx) {
				$.ajax({
					url:"./recommLoader?recommID="+idx,
					type:"GET",
					dataType:"json",
					context:this,
					error:function(request, status, error) {
						alert("fail to loading information of the item");
					},
					success:function(data) {
						$("#recommID").val(idx);
						$("#recommName").val(data["name"]);
						$("#recommUrl").val(data["url"]);
						$("#recommIntro").text(data["intro"]);
					}
				});
			}
			function add() {
				location.href="#admin";
			}
			
			
			$(document).ready(function(){
				var obj = $("#dropzone");

			     obj.on('dragenter', function (e) {
			          e.stopPropagation();
			          e.preventDefault();
			          $(this).css('border', '2px solid #5272A0');
			     });

			     obj.on('dragleave', function (e) {
			          e.stopPropagation();
			          e.preventDefault();
			          $(this).css('border', '2px dotted #8296C2');
			     });

			     obj.on('dragover', function (e) {
			          e.stopPropagation();
			          e.preventDefault();
			     });

			     obj.on('drop', function (e) {
			          e.preventDefault();
			          $(this).css('border', '2px dotted #8296C2');

			          var files = e.originalEvent.dataTransfer.files;
			          if(files.length < 1)
			               return;

			          F_FileUpload(files, obj);
			     });

			});		
			
			// 파일 업로드
			function F_FileUpload(files, obj) {
			     if(confirm("Do you want to upload \n'" + files[0].name + "'?") ) {
			         var data = new FormData();

			         data.append('file', files[0]);
			         var url = "./imageProc";
			         $.ajax({
			            url: url,
			            method: 'post',
			            data: data,
			            dataType: 'json',
			            processData: false,
			            contentType: false,
			            error:function(request, status, error) {
							alert(request + "\n" + status + "\n" + error);
						},
			            success: function(res) {			            	
			            	$('#dropzone').hide();
			            	$('#uploadImg').attr('src', res["path"]);
			            	$('#upload').attr('style', 'display:active');
			            }
			         });
			     }
			}
			
			// Jython 서블릿으로 보내기
			
			// TODO:classify 버튼 누르면 동자갛게
			function classifier() {
				
				var obj = $('#uploadImg');
				var path = obj.attr('src');
				
				if (path == "") {
					alert('input image file please');
					return;
				}
				
				var data = {'path': path};
				var jythonURL = "./imageClas";
				$.ajax({
					url: jythonURL,
					method: 'post',
					data: data,
					dataType: 'json',
					context: this,
		            error:function(request, status, error) {
						alert(request + "\n" + status + "\n" + error);
					},
		            success: function(res) {
		            	alert(res['path']);
		            }
				});
			}
			function reset() {
				$('#dropzone').show();
				$('#uploadImg').attr('src', '');
				$('#upload').attr('style', 'display:none');
			}
		</script>
	</head>
	<body class="is-preload">
		
		<%			
			String sessionID = null;
			if (session.getAttribute("sessionID") != null) {
				sessionID = (String) session.getAttribute("sessionID");
			}
		%>
		<!-- Wrapper -->
			<div id="wrapper">
				<nav id="navigator">
					<!-- <div> -->
						<ul>
							<li><span><a href="./Basic_MNIST.jsp">Basic MNIST</a></span></li>
							<li><span>/</span></li>
							<li><span><a href="./CNN_MNIST.jsp">CNN MNIST</a></span></li>
							<li><span>/</span></li>
							<li><span><a href="./Image_Recognition.jsp">Image Recognition</a></span></li>
							<li><span>/</span></li>
							<%
									if (sessionID == null) {
							%>
							<li><span><a href="#login">login</a></span></li>
							<%
									} else {
							%>
							<li><span><a href="./logOut.jsp">log out</a></span>
							<%
									}
							%>
						</ul>
					<!-- </div> -->
				</nav>
				<!-- Header -->
					<header id="header">
						<div class="logo">
							<span class="icon fa-diamond"></span>
						</div>
						<div class="content">
							<div class="inner">
								<h1>CNN MNIST</h1>
								<p>A fully responsive site template designed by <a href="https://html5up.net">HTML5 UP</a> and released<br />
								for free under the <a href="https://html5up.net/license">Creative Commons</a> license.</p>
							</div>
						</div>
						<nav>
							<ul>
								<li><a href="#intro">Intro</a></li>
								<li><a href="#work">Upload</a></li>
								<li><a href="#sites">Sites</a></li>
								<li><a href="#contact">Contact</a></li>
								<!--<li><a href="#elements">Elements</a></li>-->
							</ul>
						</nav>
					</header>

				<!-- Main -->
					<div id="main">

						<!-- Intro -->
							<article id="intro">
								<h2 class="major">CNN MNIST</h2>
								<h4>Intro</h4>
								<p>
									This model is improved version of simple MNIST model (with just 1 layer).  <br/>
									<span class="image main"><img src="https://i.imgur.com/s5DJSoM.jpg" alt="MNIST Example" /></span>
									For example, model will classify above image as 2.<br/>
									Simple MNIST model's accuracy was about 92% but this model can increase up to 99.2%.  <br/>
									Then how this improved MNIST model can increase accuracy?
								</p>
								<h4>What is CNN?</h4>
								<p>
									This improved model use CNN to extract feature. When input data of ANN model is image, it's hard to select feature of image manually. To improve accuracy of ANN model when input data type is image, we can use ANN to extract feature of image automatically. CNN is basic technology to extract feature in image. In MNIST problem, input data is image of handwritten number, So we can improve accuracy by using CNN to extract feature<br/><br/>

									CNN is consist of convolution layer and pooling layer. Convolution layer extract feature of image by matrix multiplication. Pooling layer is used to reduce feature size or emphasize specific feature.<br/><br/>

									CNN can improve accuracy of tensorflow model which handle image data. The reason of improvement is, Fully connected layer only support 1D data and image is 2D data. We need to flatten 2D image to 1D data to use fully connected layer. In this step, spatial information of 2D image is lost. To avoid lost of spatial informations, we use CNN which extract spatial information as feature. So when we use spatial data as input, we can improve accuracy by using CNN
								</p>
								<h4>Architecture</h4>
								<span class="image main"><img src="https://i.imgur.com/3Fm4XwO.jpg" alt="Basic_MNIST_Architecture" /></span>
								<p>
									Above picture depict architecture of CNN MNIST model. First layer is input layer which accept user input. Input layer accept user input as [?, 28 * 28] list. Input layer forward this value to CNN layer.<br/><br/>

									From 2nd layer to 5th layer is CNN layer. One CNN layer is consist of 1 convolution layer and 1 pulling layer. So we can say that there are 2 CNN layers. Second CNN layer forward extracted feature to ANN.<br/><br/>

									6th and 7th layer is ANN layer. This layer using feature which is extracted from CNN layer and classify number. 6th layer using ReLu as loss function and 7th layer using Softmax as loss function.<br/><br/>

									Last layer is called output layer, There are 10 neurons and the index of neuron which has the largest value will be the prediction of number from 0 to 9.
								</p>
							</article>

						<!-- Work -->
								<article id="work">
									<h2 class="major">Upload</h2>
									<div id="dropzone">Drag & Drop Your Image Here</div>
									<span id="upload" class="image main" style="display:none;"><img id="uploadImg" src="" alt="Display Image" /></span>
									<span class="image main"><img id="preview" src="images/pic02.jpg" alt="Display Image" /></span>
									<p>Upload Image! ML will detect your handwritten number.</p>
									<p>Please upload image which contains 1 number, This AI is stupid...</p>
									<ul class="actions">
										<li><button onclick="classifier()">classify</button></li>
										<li><button onclick="reset()"/>Reset</li>
									</ul>
								</article>

						<!-- Sites -->
							<article id="sites">
								<h2 class="major">sites</h2>
								
								<%
										RecommDAO recommDAO = new RecommDAO();
										ArrayList<Recomm> list = recommDAO.getList();
										for (int i=0; i<list.size(); i++) {
								%>
								
									<div>
									<ul class="icons">							
										
										<%
											if (sessionID != null){	
										%>	
												<div style="float: left;"><h3><a href="<%=list.get(i).getUrl() %>"><%=list.get(i).getName() %></a></h3></div>						
												<div style="text-align:right">
													<li><a onclick="return confirm('Do you want to delete <%=list.get(i).getName() %>?')" href="deleteAction.jsp?recommID=<%=list.get(i).getRecommID()%>" class="icon fa-trash-o"><span class="label">delete</span></a></li>
													<li><a href="#edit" onclick="edit(<%=list.get(i).getRecommID() %>)" class="icon fa-pencil"><span class="label">edit</span></a></li>		
												</div>
										<%
											} else {
										%>		
												<div style="text-align: left;"><h3><a href="<%=list.get(i).getUrl() %>"><%=list.get(i).getName() %></a></h3></div>
										<%	}
										%>			
										<blockquote><%=list.get(i).getIntro() %></blockquote>															
									</ul>
									
									</div>
																
								<%		} %>
								
								<%		
										if (sessionID != null) {
								%>
											<div style="text-align: center;"><button onclick="add()"><span class="icon fa-plus"> add</span></button></div>
								<%
										}
								%>
								
								
							</article>

						<!-- Contact -->
							<article id="contact">
								<h2 class="major">Contact</h2>
								<form method="post" action="#">
									<div class="fields">
										<div class="field half">
											<label for="contactName">Name</label>
											<input type="text" name="contactName" id="contactName" />
										</div>
										<div class="field half">
											<label for="email">Email</label>
											<input type="text" name="contactEmail" id="contactEmail" />
										</div>
										<div class="field">
											<label for="message">Message</label>
											<textarea name="message" id="message" rows="4"></textarea>
										</div>
									</div>
									<ul class="actions">
										<li><input type="submit" value="Send Message" class="primary" /></li>
										<li><input type="reset" value="Reset" /></li>
									</ul>
								</form>
								<ul class="icons">
									<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon fa-github"><span class="label">GitHub</span></a></li>
								</ul>
							</article>

						<!-- Elements -->
							<article id="elements">
								<h2 class="major">Elements</h2>

								<section>
									<h3 class="major">Text</h3>
									<p>This is <b>bold</b> and this is <strong>strong</strong>. This is <i>italic</i> and this is <em>emphasized</em>.
									This is <sup>superscript</sup> text and this is <sub>subscript</sub> text.
									This is <u>underlined</u> and this is code: <code>for (;;) { ... }</code>. Finally, <a href="#">this is a link</a>.</p>
									<hr />
									<h2>Heading Level 2</h2>
									<h3>Heading Level 3</h3>
									<h4>Heading Level 4</h4>
									<h5>Heading Level 5</h5>
									<h6>Heading Level 6</h6>
									<hr />
									<h4>Blockquote</h4>
									<blockquote>Fringilla nisl. Donec accumsan interdum nisi, quis tincidunt felis sagittis eget tempus euismod. Vestibulum ante ipsum primis in faucibus vestibulum. Blandit adipiscing eu felis iaculis volutpat ac adipiscing accumsan faucibus. Vestibulum ante ipsum primis in faucibus lorem ipsum dolor sit amet nullam adipiscing eu felis.</blockquote>
									<h4>Preformatted</h4>
									<pre><code>i = 0;

while (!deck.isInOrder()) {
    print 'Iteration ' + i;
    deck.shuffle();
    i++;
}

print 'It took ' + i + ' iterations to sort the deck.';</code></pre>
								</section>

								<section>
									<h3 class="major">Lists</h3>

									<h4>Unordered</h4>
									<ul>
										<li>Dolor pulvinar etiam.</li>
										<li>Sagittis adipiscing.</li>
										<li>Felis enim feugiat.</li>
									</ul>

									<h4>Alternate</h4>
									<ul class="alt">
										<li>Dolor pulvinar etiam.</li>
										<li>Sagittis adipiscing.</li>
										<li>Felis enim feugiat.</li>
									</ul>

									<h4>Ordered</h4>
									<ol>
										<li>Dolor pulvinar etiam.</li>
										<li>Etiam vel felis viverra.</li>
										<li>Felis enim feugiat.</li>
										<li>Dolor pulvinar etiam.</li>
										<li>Etiam vel felis lorem.</li>
										<li>Felis enim et feugiat.</li>
									</ol>
									<h4>Icons</h4>
									<ul class="icons">
										<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
										<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
										<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
										<li><a href="#" class="icon fa-github"><span class="label">Github</span></a></li>
									</ul>

									<h4>Actions</h4>
									<ul class="actions">
										<li><a href="#" class="button primary">Default</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
									<ul class="actions stacked">
										<li><a href="#" class="button primary">Default</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
								</section>

								<section>
									<h3 class="major">Table</h3>
									<h4>Default</h4>
									<div class="table-wrapper">
										<table>
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>

									<h4>Alternate</h4>
									<div class="table-wrapper">
										<table class="alt">
											<thead>
												<tr>
													<th>Name</th>
													<th>Description</th>
													<th>Price</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>Item One</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Two</td>
													<td>Vis ac commodo adipiscing arcu aliquet.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Three</td>
													<td> Morbi faucibus arcu accumsan lorem.</td>
													<td>29.99</td>
												</tr>
												<tr>
													<td>Item Four</td>
													<td>Vitae integer tempus condimentum.</td>
													<td>19.99</td>
												</tr>
												<tr>
													<td>Item Five</td>
													<td>Ante turpis integer aliquet porttitor.</td>
													<td>29.99</td>
												</tr>
											</tbody>
											<tfoot>
												<tr>
													<td colspan="2"></td>
													<td>100.00</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</section>

								<section>
									<h3 class="major">Buttons</h3>
									<ul class="actions">
										<li><a href="#" class="button primary">Primary</a></li>
										<li><a href="#" class="button">Default</a></li>
									</ul>
									<ul class="actions">
										<li><a href="#" class="button">Default</a></li>
										<li><a href="#" class="button small">Small</a></li>
									</ul>
									<ul class="actions">
										<li><a href="#" class="button primary icon fa-download">Icon</a></li>
										<li><a href="#" class="button icon fa-download">Icon</a></li>
									</ul>
									<ul class="actions">
										<li><span class="button primary disabled">Disabled</span></li>
										<li><span class="button disabled">Disabled</span></li>
									</ul>
								</section>

								<section>
									<h3 class="major">Form</h3>
									<form method="post" action="#">
										<div class="fields">
											<div class="field half">
												<label for="demo-name">Name</label>
												<input type="text" name="demo-name" id="demo-name" value="" placeholder="Jane Doe" />
											</div>
											<div class="field half">
												<label for="demo-email">Email</label>
												<input type="email" name="demo-email" id="demo-email" value="" placeholder="jane@untitled.tld" />
											</div>
											<div class="field">
												<label for="demo-category">Category</label>
												<select name="demo-category" id="demo-category">
													<option value="">-</option>
													<option value="1">Manufacturing</option>
													<option value="1">Shipping</option>
													<option value="1">Administration</option>
													<option value="1">Human Resources</option>
												</select>
											</div>
											<div class="field half">
												<input type="radio" id="demo-priority-low" name="demo-priority" checked>
												<label for="demo-priority-low">Low</label>
											</div>
											<div class="field half">
												<input type="radio" id="demo-priority-high" name="demo-priority">
												<label for="demo-priority-high">High</label>
											</div>
											<div class="field half">
												<input type="checkbox" id="demo-copy" name="demo-copy">
												<label for="demo-copy">Email me a copy</label>
											</div>
											<div class="field half">
												<input type="checkbox" id="demo-human" name="demo-human" checked>
												<label for="demo-human">Not a robot</label>
											</div>
											<div class="field">
												<label for="demo-message">Message</label>
												<textarea name="demo-message" id="demo-message" placeholder="Enter your message" rows="6"></textarea>
											</div>
										</div>
										<ul class="actions">
											<li><input type="submit" value="Send Message" class="primary" /></li>
											<li><input type="reset" value="Reset" /></li>
										</ul>
									</form>
								</section>

							</article>
						<!-- login -->
							<article id="login">
								<h2 class="major">Login</h2>
								<form method="post" action="./loginAction.jsp">
									<div class="fields">
										<div class="field half">
											<label for="email">Email</label>
											<input type="text" name="email" id="email" />
										</div>
										<div class="field half">
											<label for="pw">Password</label>
											<input type="password" name="pw" id="pw" />
										</div>
									</div>
									<ul class="actions">
										<li><input type="submit" value="login" class="primary" /></li>
										<li><input type="reset" value="Reset" /></li>
									</ul>			
								</form>							
							</article>
						<!-- admin -->
							<article id="admin">
								<h2 class="major">sites admin</h2>
								<form method="post" action="./recommRegister">
									<div class="fields">
										<div class="field half">
											<label for="name">Site name</label>
											<input type="text" name="name" id="name" />
										</div>
										<div class="field half">
											<label for="url">URL</label>
											<input type="text" name="url" id="url" />
										</div>
										<div class="field">
											<label for="intro">Intro</label>
											<textarea name="intro" id="intro" rows="4"></textarea>
										</div>
									</div>
									<ul class="actions">
										<li><input type="submit" value="register" class="primary" /></li>
										<li><input type="reset" value="Reset" /></li>
									</ul>			
								</form>
							</article>
						<!-- edit -->
							<article id="edit">
								<h2 class="major">Edit List</h2>
								<form method="post" action="./recommUpdate">
									<input type="text" name="recommID" id="recommID" style="display:none;"/>
									<div class="fields">
										<div class="field half">
											<label for="recommName">Site name</label>
											<input type="text" name="recommName" id="recommName"/>
										</div>
											<div class="field half">
												<label for="recommUrl">URL</label>
												<input type="text" name="recommUrl" id="recommUrl" />
											</div>
										<div class="field">
											<label for="recommIntro">Intro</label>
											<textarea name="recommIntro" id="recommIntro" rows="4"></textarea>
										</div>
									</div>
									<ul class="actions">
										<li><input type="submit" value="edit" class="primary" /></li>
										<li><input type="reset" value="Reset" /></li>
									</ul>			
								</form>
							</article>
					</div>

				<!-- Footer -->
					<footer id="footer">
						<p class="copyright">&copy; Untitled. Design: <a href="https://html5up.net">HTML5 UP</a>.</p>
					</footer>

			</div>

		<!-- BG -->
			<div id="bg"></div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>
