package bean;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.mariadb.jdbc.Driver;


public class Employee_InfoBean {
	private static final List<Employee_InfoBean> answer = null;
	private String employee_id;
	private String name;

	public Employee_InfoBean() {}
	public Employee_InfoBean(String employee_id,String name) {
		this.employee_id=employee_id;
		this.name=name;
	}

	public String getEmployee_id() {return employee_id;}
	public String getName() {return name;}

	public List<Employee_InfoBean> Employee_InfoDBtoList(String selectEmployee_id,String selectName){
		List<Employee_InfoBean> list = new ArrayList<Employee_InfoBean>();
		Connection con = null;
		PreparedStatement ps = null;
		try {
			Driver.class.getDeclaredConstructor().newInstance();
			con = DriverManager.getConnection("jdbc:mariadb://localhost/studyDB", "root", "");


			String sql ="select * from employee_info where employee_id = ? and name = ?";
			ps = con.prepareStatement(sql.toString());
			ps.setString(1,selectEmployee_id);
			ps.setString(2,selectName);
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

}