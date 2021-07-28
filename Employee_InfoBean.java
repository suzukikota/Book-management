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

	public Employee_InfoBean() {}
	public Employee_InfoBean(String employee_id,String name) {
		this.employee_id=employee_id;
		this.name=name;
	}

	public String getEmployee_id() {return employee_id;}
	public String getName() {return name;}

	@SuppressWarnings("resource")
	public List<Employee_InfoBean> Employee_InfoDBtoList(String selectId,String id, String names, String btn){
		List<Employee_InfoBean> list = new ArrayList<Employee_InfoBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql ="select * from employee_info order by cast(employee_id as int)";
			ps = con.prepareStatement(sql.toString());



			if(btn.equals("delete")) {
				sql = "delete from employee_info where employee_id = ? ";
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, selectId);
				ps.executeUpdate();
			}

			if(btn.equals("’Ç‰Á")) {
				sql = "insert into employee_info (employee_id,name) values (?, ?)"; // ’Ç‰Á
				ps = con.prepareStatement(sql.toString());
				ps.setString(1, id);
				ps.setString(2, names);
				ps.executeUpdate();
			}

			sql ="select * from employee_info order by cast(employee_id as int)";
			ps = con.prepareStatement(sql.toString());
			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				String employee_id = rs.getString("employee_id");
				String name = rs.getString("name");

				list.add(new Employee_InfoBean(employee_id,name));

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
		PreparedStatement pS = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");

			String sql="select * from employee_info order by name;";

			pS=con.prepareStatement(sql.toString());
			ResultSet rs = pS.executeQuery();
			while(rs.next()) {
				String employee_id = rs.getString("employee_id");
				String name = rs.getString("name");

				list2.add(new Employee_InfoBean(employee_id,name));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(pS !=null) {pS.close();}
				if(con !=null) {con.close();}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list2;
	}

}