package com.gui.controllers;
import java.util.List;

import javax.ejb.EJB;
import javax.faces.bean.ManagedBean;
import com.ejb.services.EmployeeService;
import com.jpa.entities.Employee;
@ManagedBean
public class EmployeeController {
	
	private int id=0;
	private Employee employee = new Employee();
	private int sid=0;
	private int newsalary=0;
	
	
	@EJB
	private EmployeeService service;
	public Employee getEmployee() {
		return employee;
	}
	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	
	public int getSid() {
		return sid;
	}
	public void setSid(int sid) {
		this.sid = sid;
	}
	
	
	public int getNewsalary() {
		return newsalary;
	}
	public void setNewsalary(int newsalary) {
		this.newsalary = newsalary;
	}
	
	public void saveEmployee(Employee emp) {
		service.addEmployee(emp);
	}
	
	public void removeEmployee(int id) {
		service.deleteEmployee(id);
	}
	
	public void updateEmployee(int id, int newsalary) {
		service.upgradeEmployee(id, newsalary);
	}
	
	public List<Employee> listEmployees(){
   		List<Employee> allEmployees=service.listEmployees();
   		return allEmployees;
   	}
	

	
}