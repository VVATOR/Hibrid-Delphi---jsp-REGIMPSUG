package vva.oracle;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class OracleConnect {
	public static Connection oCon;
	public String connectionString="";
	public String SERVERIP="";
	public String PORT="";
	public String DATABASENAME="";
	public String NAME="";
	private String PASSWORD="";
	
	public OracleConnect(String serverip, String port, String databasename, String name, String password){
		this.SERVERIP = serverip;
		this.PORT = port;
		this.DATABASENAME = databasename;
		this.NAME   = name;
		this.PASSWORD = password;
		connectionString = "jdbc:oracle:thin:@"+SERVERIP+":"+PORT+":"+DATABASENAME;		
		
	}
	
	public void setCon(Connection con){
		OracleConnect.oCon = con;
	}
	
	public Connection getCon(){
		return OracleConnect.oCon;
	}
	
	public void disconnect() throws SQLException{
		OracleConnect.oCon.close();
	}
	
	public void getConnection() throws SQLException{
		
		  try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			System.out.println("Error: Driver database not found!");
			e.printStackTrace();
		}		  
		  setCon(DriverManager.getConnection(connectionString,this.NAME,this.PASSWORD));
	}
	
	
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
