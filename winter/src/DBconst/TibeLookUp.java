package DBconst;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
 
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Hashtable;

import com.tmax.tibero.jdbc.*;
import com.tmax.tibero.jdbc.ext.*;

public class TibeLookUp {
	String hostname="10.10.0.52:8629";
    String username="jw";
    String password="root";
    
    String jndiName="winter";
    DataSource ds;
    
    
    InitialContext ctx = null;
    @SuppressWarnings("unchecked")
	public TibeLookUp() {}
    
    public Connection getConnection()                                                    
    {                                                                                    
    	Connection connection = null;   
      
        try                                                                                
        {                                                                                  
        	if (ctx == null) {                                                                                             
        		ctx = new InitialContext();                     
        		ds = (DataSource)ctx.lookup(this.jndiName);
        	}                                                                                
        	connection = ds.getConnection();                                                 
        	connection.setAutoCommit(false);                                                 
        } catch (NamingException ne) {
        	System.out.println("<<<<<<<NamingException Occurred>>>>>>>");
        	ne.printStackTrace();    
        } catch (SQLException se) {
        	System.out.println("<<<<<<<SQLException Occurred>>>>>>>");
        	se.printStackTrace();
        } finally {
        	try {
        		ctx.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}
        }
                                                                                          
        return connection;                                                                 
    }
}
