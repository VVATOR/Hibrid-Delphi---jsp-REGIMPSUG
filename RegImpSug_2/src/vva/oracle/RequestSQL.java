package vva.oracle;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ResourceBundle;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RequestSQL {
	private OracleConnect oC=null;
	public Statement stmt = null;
	public ResultSet rs   = null;
	public int  iQueryTime=2400;
	
	public RequestSQL() throws SQLException{
		ResourceBundle resource = ResourceBundle.getBundle("database");
		String name =resource.getString("name");
		String password =resource.getString("password");
		String serverip =resource.getString("serverip");
		String databasename =resource.getString("databasename");
		String port =resource.getString("port");
		oC = new OracleConnect(serverip, port,  databasename,  name,  password);
		//подключить
		oC.getConnection();
		//Создаем statment (оператор) для выполнения SQL-запроса
		stmt = oC.getCon().createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
	}
		
	/**
	 * if text equals NULL (example data from base) then text replace on nullReplacement (example: '' / 0 / ' '/"null"...)
	 * @param text
	 * @param nullReplacement
	 * @return
	 */
	public static String notNULL(String text,String nullReplacement ){		
		if((text==null)){
			text=nullReplacement;
		}
		return text;
	}
	
	
	
	
/**
 * if text equals NULL (example data from base) then text replace on nullReplacement (example: '' / 0 / ' '/"null"...)
 * @param text
 * @param nullReplacement
 * @return
 */
public static String replaceOldSimbol (String text,String nullReplacement ){		
	if((text==null)){
		text=nullReplacement;
	}
	return Pattern.compile(" Ф ").matcher(text).replaceAll(nullReplacement);
}
	
	
	/**
	 * get tabel number 
	 * @param fio
	 * @return
	 * @throws SQLException
	 */
	public String getTN(String fio) throws SQLException{
		String sql="select distinct AUTHOR_TN "
				+ " from "
				+ "        MRP.IMPR_AUTHORS au "
				+ "        inner join PROEUSER.USERS u on("
				+ "        ( "
				+ "            trim(regexp_replace(au.AUTHOR_FIO,'  *',' ')) "
				+ "            = "
				+ "            trim(regexp_replace(u.FULLNAME,'  *',' ')) "
				+ "         ) "
				+ "          or "
				+ "         ( "
				+ "            trim(regexp_replace(au.AUTHOR_FIO,'  *',' ')) "
				+ "            = "
				+ "            trim(regexp_replace(u.lastname||' '||u.firstname||' '||u.otchestvo,'  *',' ')) "
				+ "         )"
				+ "           or "
				+ "         ( "
				+ "            trim(regexp_replace(au.AUTHOR_FIO,'  *',' '))"
				+ "            = "
				+ "            trim(regexp_replace(u.lastname||' '||substr(u.firstname,2)||'. '||substr(u.otchestvo,2),'  *',' ')) "
				+ "          ) "
				+ "        )"
				+ " where au.AUTHOR_FIO='"+fio+"' and au.author_tn is not null"; 
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);
		rs.next();
		return rs.getString(1).equals(null)?"":rs.getString(1);
	}
	
	
	
	public String parse_F_I_O(String fio, char f_i_o) throws SQLException{
		String result="";
		if(f_i_o=='i'){			
			Pattern p = Pattern.compile("( ).+(\\1)");  
	        Matcher m = p.matcher(fio);  
	        if(m.find()){  
	        	result=m.group().trim();  
	        }  
		}
		if(f_i_o=='f'){
			result = Pattern.compile(" .*$").matcher(fio).replaceAll("");		
		}
		if(f_i_o=='o'){
			result = Pattern.compile("^.* ").matcher(fio).replaceAll("");		
		}
		return result;
		
	}
	 
	public void selectBestInnovator(String date1,String date2, String countBEST) throws SQLException{
		System.out.println(date1+'-'+date2);
			
			System.out.println(date1);
			if(date1.equals(null)||date2.equals(null)||countBEST.equals(null)){
				return;
			}
				String sql =  "  SELECT rownum,  all_n.* "
							+ "  from "
							//+ "  (SELECT data.* from "
							+ "						     (SELECT dannie.* from "
							+ "						            (SELECT "
							+ "								           s.AUTHOR_FIO AUTHOR_FIO, "
							+ "								           count(*) podano, "
							+ "								           sum(s.intro) intro, "
							+ "								           sum(ED_) Summa_ED "
							+ "  								 FROM   MRP.VIEW_IMPR_STAT s, "
							+ "								        PROEUSER.USERS u "
							+ " 								 WHERE "
							+ "								        ("
							+ "							        		( "
							+ "								         	  trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "								         	  =  "
							+ "								         	  trim(regexp_replace(u.FULLNAME,'  *',' ')) "
							+ "								             ) "
							+ "								            or "
							+ "	   							          	( "
							+ "								               trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "								               = "
							+ "								               trim(regexp_replace(u.lastname||' '||u.firstname||' '||u.otchestvo,'  *',' ')) "
							+ " 							             ) "
							+ "								            or "
							+ "								             ( "
							+ " 							               trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "								               = "
							+ "								               trim(regexp_replace(u.lastname||' '||substr(u.firstname,2)||'. '||substr(u.otchestvo,2),'  *',' ')) "
							+ "								             ) "
							+ "								        ) "
							+ "								        and  (s.AUTHOR_TN=u.T_NUMBER and AUTHOR_TN is not null) "
							+ "								        and "
							+ "								        ( "
							+ "									         (s.DATE_CREATE>='"+date1+"' and s.DATE_CREATE<='"+date2+"') "
							+ "											  or "
							+ "									         (s.INTRO_DATE>='"+date1+"' and s.INTRO_DATE<='"+date2+"') "
							+ "								        ) "
							+ " 								 GROUP BY s.AUTHOR_FIO"
							+ "								) dannie  "
						//	+ "							)data  "
						/*	+ "			where "
							+ "                  data.Summa_ED  "
							+ "                  in (select distinct gms.max_summ_ed "
							+ "                      from "
							+ "                        (select "
							+ "                            sum(ed_) max_summ_ed "
							+ "                          from "
							+ "                            MRP.VIEW_IMPR_STAT  s "
							+ "                          group by author_fio "
							+ "                          order by max_summ_ed desc "
							+ "                        ) gms "
							+ "                      where rownum<="+countBEST +" "
							+ "                      and  max_summ_ed is not null "
							+ "                      ) "*/
							+ " where summa_ed is not null "
							+ "	Order by Summa_ed desc, intro desc, podano desc "
							+ " )all_n "
							+ " where rownum<="+countBEST +" ";
				
			stmt.setQueryTimeout(iQueryTime);
			rs = stmt.executeQuery(sql);
		}
			
	
	
	
	
	public void getMainTableSuggestion() throws SQLException{
		String sql="select"
				+ "  is_.int_number, "
				+ "  is_.id_impr_sug, "
				+ "  is_.ext_number, "
				+ "  to_char(is_.date_reg_factory, 'dd.mm.yyyy') date_reg_factory, "
				+ "  to_char(is_.date_reg_gskb, 'dd.mm.yyyy') date_reg_gskb, "
				+ "  is_.summary, "
				+ "  is_.enterprise, "
				+ "  mrp.orders_concat_str(cursor(select impr_authors.author_fio from mrp.impr_authors where impr_authors.id_impr_sug = is_.id_impr_sug), '; ') fio, "
				+ "  is_.node, "
				+ "  mrp.impr_cur_status(is_.id_impr_sug) status, "
				+ "  p_status "
				+ "from "
				+ "  mrp.impr_suggestion is_ "
				+ "where "
				+ "  is_.del = 0 "
				+ "order by is_.int_number";
		stmt.setQueryTimeout(iQueryTime);
		rs=stmt.executeQuery(sql);		
	}
			
	
	
	public void selectCartochka(String fio) throws SQLException  {
		System.out.println(fio);
		
			/*String sql =  " SELECT rownum, s.*"
					+ " from "
					+ "  (select *"
					+ "	  FROM "
					+ "	     MRP.IMPR_SUGGESTION sug "
					+ "    inner join "
					+ "      MRP.IMPR_AUTHORS aut "
					+ "    on(sug.id_impr_sug=aut.ID_IMPR_SUG) "
					+ "   order by aut.AUTHOR_FIO asc"
					+ "  ) s "
					+ "where (AUTHOR_TN is not null) "
					+ " and author_fio ='"+fio+"'  ";*/
		
		String sql =  "SELECT rownum, s.*, a.* "
				+ " FROM MRP.IMPR_SUGGESTION s inner join MRP.impr_authors a "
				+ " on (s.id_impr_sug=a.ID_IMPR_SUG)"
				+ " where a.AUTHOR_FIO='"+fio+"'"; 
		
			stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);
		System.out.println("qqqqqqq"+fio);
		//System.out.print(rs.getString(1));
	}
		
	;
	
	
	/**
	 * @param date1
	 * @param date2
	 * @param idDep
	 * @throws SQLException
	 * 
	 */
	public void selectAll(String date1,String date2, String idDep) throws SQLException{
		System.out.println(date1);
		if(date1.equals(null)||date2.equals(null)||idDep.equals(null)){
			return;
		}
			String sql = "SELECT rownum, dannie.* from "
					        + "    (SELECT "
							+ "           s.AUTHOR_FIO AUTHOR_FIO, "
							+ "           count(*) podano, "
							+ "           sum(s.intro) intro, "
							+ "           sum(ED_) ED  "		
							+ " FROM   MRP.VIEW_IMPR_STAT s, "
							+ "        PROEUSER.USERS u "
							+ " WHERE "
							+ "        ( "
							+ "        		( "
							+ "         	  trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "         	  = "
							+ "         	  trim(regexp_replace(u.FULLNAME,'  *',' ')) "
							+ "             )"
							+ "            or "
							+ "          	( "
							+ "               trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "               = "
							+ "               trim(regexp_replace(u.lastname||' '||u.firstname||' '||u.otchestvo,'  *',' ')) "
							+ "             ) "
							+ "            or  "
							+ "             ( "
							+ "               trim(regexp_replace(s.AUTHOR_FIO,'  *',' ')) "
							+ "               = "
							+ "               trim(regexp_replace(u.lastname||' '||substr(u.firstname,2)||'. '||substr(u.otchestvo,2),'  *',' ')) "
							+ "             ) "
							+ "        ) "
							+ "        and  (s.AUTHOR_TN=u.T_NUMBER and AUTHOR_TN is not null) "
							+ "        and "
							+ "        ( "
							+ "	         (s.DATE_CREATE>='"+date1+"' and s.DATE_CREATE<='"+date2+"') "
							+ "			  or "
							+ "	         (s.INTRO_DATE>='"+date1+"' and s.INTRO_DATE<='"+date2+"') "
							+ "        ) "
							+ "        and (s.DEPARTMENT_ID='"+idDep+"' ) "
							+ " GROUP BY s.AUTHOR_FIO"
							+ " order by AUTHOR_FIO asc "							
							+ ") dannie "
							+ "";
			
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);
	}
		 
	
	
	
	
	public void selStat(String date1, String date2) throws SQLException{
		
			String sql = "SELECT "
					+ "  v.* "
					+ " FROM "
					+ "  MRP.VIEW_IMPR_stat v "
					+ "  inner join "
					+ "  PROEUSER.USERS u on( "
					+ "                         v.AUTHOR_FIO = (u.lastname||' '||u.FIRSTNAME||' '||u.otchestvo) "
					+ "                       or "
					+ "                         trim(regexp_replace(v.AUTHOR_FIO,'  *',' ')) "
					+ "                         = "
					+ "                         trim(regexp_replace((u.lastname||' '||substr(u.FIRSTNAME,0,1)||'.'||substr(u.otchestvo,0,1)||'.'),'  *',' ')) "
					+ "                       and "
					+ "                         v.author_tn=u.T_NUMBER "
					+ "                      ) "
					+ " WHERE summaall is not null ";
			
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);
	}
	
	public void selStat1(String idDep, String date1, String date2) throws SQLException{
		
		String sql = "SELECT "
				+ "  v.* "
				+ " FROM "
				+ "  MRP.VIEW_IMPR_stat v "
				+ "  inner join "
				+ "  PROEUSER.USERS u on( "
				+ "                         v.AUTHOR_FIO = (u.lastname||' '||u.FIRSTNAME||' '||u.otchestvo) "
				+ "                       or "
				+ "                         trim(regexp_replace(v.AUTHOR_FIO,'  *',' ')) "
				+ "                         = "
				+ "                         trim(regexp_replace((u.lastname||' '||substr(u.FIRSTNAME,0,1)||'.'||substr(u.otchestvo,0,1)||'.'),'  *',' ')) "
				+ "                       and "
				+ "                         v.author_tn=u.T_NUMBER "
				+ "                      ) "
				+ " WHERE summaall is not null "
				+ "        and "
				+ "       u.DEPARTMENT_ID='"+idDep+"' ";
		
	stmt.setQueryTimeout(iQueryTime);
	rs = stmt.executeQuery(sql);
}
	
	
	public void selectSimbolicText(String fio) throws SQLException{
		System.out.println(fio);
			String sql = "select * from MRP.IMPR_V";
			
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);
	}
	
	public void deleteAllSimbolic() throws SQLException{
		String sql = "delete from MRP.IMPR_V";		
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql);		
	}
	
	public void insertSimbolicText(String text) throws SQLException{
		System.out.println("q:"+text);
		//text.replaceAll("&","chr(38)");
		text.replaceAll("u/","-=vva=-");
		text.replaceAll("&","chr(38)");
		
			String sql = "insert into  MRP.IMPR_V (q1,q) values('"+text+"', 11)";
			
		stmt.setQueryTimeout(iQueryTime);
		stmt.executeUpdate(sql);
	}
	
	

	/**
	 * get count suggestion from date interval (NOT DELETED)
	 * @param date1
	 * @param date2
	 * @return
	 * @throws SQLException
	 */
	public String getSuggestionCount(String date1,String date2) throws SQLException{
		if(date1.equals(null) || date2.equals(null)){			
			return null ;
		}	
		
		String sql=" SELECT count(*)"
				+ "  FROM "
				+ "   MRP.IMPR_SUGGESTION s "
				+ "  where "
				+ "    s.DATE_CREATE between TO_DATE('"+date1+"') and TO_DATE('"+date2+"')"
				+ "   or "
				+ "    s.DATE_CREATE between TO_DATE('"+date2+"') and TO_DATE('"+date1+"')"
				+ "   and del<>1 ";

		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 			
		rs.next();		
		return rs.getString(1);
	}
	
	
	/**
	 * @param date1
	 * @param date2
	 * @return get count intro suggestion from date interval NOT DELETED)
	 * @throws SQLException	
	 */
	public String getSuggestionIntoCount(String date1,String date2) throws SQLException{
		if(date1.equals(null) || date2.equals(null)){			
			return null ;
		}	
		
		String sql=" SELECT count(*)"
				+ "  FROM "
				+ "   MRP.IMPR_SUGGESTION s "
				+ "  where "
				+ "    (s.DATE_CREATE between TO_DATE('"+date1+"') and TO_DATE('"+date2+"')"
				+ "   or "
				+ "    s.DATE_CREATE between TO_DATE('"+date2+"') and TO_DATE('"+date1+"')"
				+ "	  and del<>1) "
				+ "   and s.intro_date is not null ";

		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 
		System.out.println(sql);
		
		rs.next();		
		return rs.getString(1);
	}	
	
	
	public String getRacorgNameByLogin(String login) throws SQLException{
		String sql=" select lastname||' '||regexp_substr(firstname,'.',1)||'. '||regexp_substr(otchestvo,'.',1)||'.' iniciali"
				+ "  from "
				+ "   proeuser.users "
				+ "  where Upper(Proeuser.users.login)=Upper('"+login+"')";
		
		stmt.setQueryTimeout(iQueryTime);
		rs=stmt.executeQuery(sql);
		rs.next();
		return rs.getString(1);
	}
	
	
	
	public void getAllDepartment() throws SQLException{
		String sql= " select * "
				+ " from "
				+ " proeuser.department dep "
				+ " order by department asc ";
		
		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 
		System.out.println(sql);
	}
	
	
	
	public void getRacikUserByDepartment(String department) throws SQLException{
		String sql= " select u.login,u.fullname,u.firstname,u.otchestvo,u.lastname "
				+ " from "
				+ " proeuser.department d inner join proeuser.users u on(d.ID=u.department_id) "
				+ " where "
				+ "	u.user_status<>2  and " 
				+ " u.T_NUMBER is not null "
				+ " and "
				+ " d.department='"+department+"' "
				+ " order by u.lastname asc";
	
	stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 
		System.out.println(sql);
	}
	
	public void getRacikUserByDepartment1(String department) throws SQLException{
		String sql= " SELECT * FROM MRP.VIEW_IMPR_STAT ";
	
	stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 
		System.out.println(sql);
	}
	
	
	
	
	public String getSuggestionSumEconomy(String date1,String date2) throws SQLException{
		if(date1.equals(null) || date2.equals(null)){			
			return null ;
		}	
		
		String sql=" SELECT count(*)"
				+ "  FROM "
				+ "   MRP.IMPR_SUGGESTION s "
				+ "  where "
				+ "    (s.DATE_CREATE between TO_DATE('"+date1+"') and TO_DATE('"+date2+"')"
				+ "   or "
				+ "    s.DATE_CREATE between TO_DATE('"+date2+"') and TO_DATE('"+date1+"')"
				+ "	  and del<>1 ) "
				+ "   and s.intro_date is not null ";

		stmt.setQueryTimeout(iQueryTime);
		rs = stmt.executeQuery(sql); 
		System.out.println(sql);
		
		rs.next();		
		return rs.getString(1);
	}	
	/*public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		RequestSQL requestSQL = new RequestSQL();
		requestSQL.selectQ("Мешкова Ирина Евгеньевна");
		while(requestSQL.rs.next()){
			System.out.println(requestSQL.rs.getString(1));
			
		}
	}
*/
}
