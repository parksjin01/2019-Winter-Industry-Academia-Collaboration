package DBconst;
import javax.naming.Context;
import javax.naming.InitialContext;
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
    
    String jndiName="tibero";
    Hashtable env;
    DataSource ds;
    
    
    InitialContext ctx;
    @SuppressWarnings("unchecked")
	public TibeLookUp() {
    	// TODO Auto-generated constructor stub
	    env = new Hashtable();
	    env.put(Context.INITIAL_CONTEXT_FACTORY, "jeus.jndi.JEUSContextFactory");
	    env.put(Context.URL_PKG_PREFIXES, "jeus.jndi.jns.url");
	    env.put(Context.PROVIDER_URL, hostname);
	    env.put(Context.SECURITY_PRINCIPAL, username);
	    env.put(Context.SECURITY_CREDENTIALS, password);
    }
    
    public Connection getConnection()                                                    
    {                                                                                    
    	Connection connection = null;   
      
        try                                                                                
        {                                                                                  
        	if (ctx == null) {                                                                                             
        		ctx = new InitialContext(env);                     
        		ds = (DataSource)ctx.lookup(this.jndiName);
        	}                                                                                
        	connection = ds.getConnection();                                                 
        	connection.setAutoCommit(false);                                                 
        } catch (Exception e) {                                                            
        	e.printStackTrace();    
        }                                                                                  
                                                                                          
        return connection;                                                                 
    }
}
