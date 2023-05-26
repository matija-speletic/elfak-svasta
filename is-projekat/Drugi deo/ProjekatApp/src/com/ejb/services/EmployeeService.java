package com.ejb.services;
import java.util.List;

import com.jpa.entities.Employee;
public interface EmployeeService {
	public void addEmployee(Employee emp);
	public void deleteEmployee(int id);
	public void upgradeEmployee(int id, int newsalary);
	public List<Employee> listEmployees();
}

