package bean;

public class BorrowBean {
	private String employee_id;
	private String isbn;
	private String status;
	private String borrow_date;

	public BorrowBean() {}
	public BorrowBean(String employee_id,String isbn,String status,String borrow_date) {
		this.employee_id=employee_id;
		this.isbn=isbn;
		this.status=status;
		this.borrow_date=borrow_date;
	}
	public String getEmployee_id() {return employee_id;}
	public String getIsbn() {return isbn;}
	public String getStatus() {return status;}
	public String getBorrow_date() {return borrow_date;}
}
