package image;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String line = null;
		try{
			String[] command = {"python", "improved_model_load.py", "/Users/Knight/Documents/GitHub/2019-Winter-Industry-Academia-Collaboration/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/winter/upload/handwritten1.jpeg", "/Users/Knight/Documents/GitHub/2019-Winter-Industry-Academia-Collaboration/MNIST/MNIST_MODEL_IMPROVED"};
			String[] env = {"PATH=/opt/local/bin:/opt/local/sbin:/Users/Knight/Library/Android/sdk/tools:/Users/Knight/Library/Android/sdk/platform-tools:/usr/sbin:/usr/bin:/sbin:/bin:/Users/Knight/test:/Users/Knight/ns3.28:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/CrossPack-AVR/bin:/Applications/Wireshark.app/Contents/MacOS",
					"PYTHONPATH=/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/Library/Frameworks/Python.framework/Versions/3.4/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/CrossPack-AVR/bin:/Applications/Wireshark.app/Contents/MacOS"};
		    Process p = Runtime.getRuntime().exec(command, env);
		    BufferedReader br = new BufferedReader(new InputStreamReader(p.getInputStream()));
		    BufferedReader stdError = new BufferedReader(new InputStreamReader(p.getErrorStream()));
		   
		    while((line = br.readLine()) != null){
		        System.out.println(line);
		    }
		    
		    while((line = stdError.readLine()) != null){
		        System.out.println(line);
		    }
		}
		catch(Exception e) {
			System.out.println(e);
		}
	}

}
