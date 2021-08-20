package bean;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.mariadb.jdbc.Driver;

public class Employee_InfoBean {

	private String employee_id;
	private String name;
	private String delete_date;
	private String mail;

	public Employee_InfoBean() {}
	public Employee_InfoBean(String employee_id,String name,String delete_date,String mail) {
		this.employee_id=employee_id;
		this.name=name;
		this.delete_date=delete_date;
		this.mail=mail;
	}

	public String getEmployee_id() {return employee_id;}
	public String getName() {return name;}
	public String delete_date() {return delete_date;}
	public String getMail() {return mail;}

	@SuppressWarnings("resource")
	public List<Employee_InfoBean> Employee_InfoDBtoList(String selectId,String id, String names, String btn){
		List<Employee_InfoBean> list = new ArrayList<Employee_InfoBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql ="select * from employee_info where delete_date != '削除'  order by cast(employee_id as int)";
			ps = con.prepareStatement(sql.toString());


			if(btn.equals("delete")) {
				sql = "update employee_info set delete_date = '削除'  where employee_id = ? ";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("追加")) {
				sql = "insert into employee_info (employee_id,name,delete_date) values (?, ?, ?)";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, id);
				ps.setString(2, names);
				ps.setString(3, "");
				ps.executeUpdate();
			}

			sql ="select * from employee_info where delete_date != '削除'  order by cast(employee_id as int)";
			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				String employee_id = rs.getString("employee_id");
				String name = rs.getString("name");
				list.add(new Employee_InfoBean(employee_id,name,delete_date,mail));
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (ps != null) { ps.close();}
				if (con != null) { con.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	//	レンタルと返却申請の際の、社員id,nameの取得
	public List<Employee_InfoBean> Employee_InfoDBtoList2(){
		List<Employee_InfoBean> list2 =new ArrayList<Employee_InfoBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select * from employee_info where delete_date != '削除'  order by name;";

			ps=con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String employee_id = rs.getString("employee_id");
				String name = rs.getString("name");

				list2.add(new Employee_InfoBean(employee_id,name,delete_date,mail));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps !=null) {ps.close();}
				if(con !=null) {con.close();}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list2;
	}

//	社員のメールアドレス取得
	public List<Employee_InfoBean> Employee_InfoDBtoList3(String selectName){
		List<Employee_InfoBean> list = new ArrayList<Employee_InfoBean>();
		Connection con=null;
		PreparedStatement ps=null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select mail from employee_info where name =?";

			ps=con.prepareStatement(sql.toString());
			ps.setString(1, selectName);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				String mail = rs.getString("mail");

				list.add(new Employee_InfoBean(employee_id,name,delete_date,mail));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try {
					if(ps !=null) {ps.close();}
					if(con !=null) {con.close();}
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return list;
		}

}