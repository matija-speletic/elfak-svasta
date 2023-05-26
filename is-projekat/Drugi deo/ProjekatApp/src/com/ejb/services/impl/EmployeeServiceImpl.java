package com.ejb.services.impl;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import com.ejb.services.EmployeeService;
import com.jpa.entities.Employee;
@Stateless
public class EmployeeServiceImpl implements EmployeeService {
	@PersistenceContext(name = "EmployeeApp")
	private EntityManager em;
	@Override
	public void addEmployee(Employee emp) {
		em.persist(emp);
	}
	@Override
	public void deleteEmployee(int id) {
		Employee e=em.find(Employee.class,id);
		em.remove(e);
	}
	@Override
	public void upgradeEmployee(int id, int newsalary) {
		Employee e=em.find(Employee.class,id);
		e.setSalary(newsalary);
	}
	
	@Override
	public List<Employee> listEmployees() {

		List<Employee> allEmployees = em.createQuery("SELECT e FROM Employee e", Employee.class).getResultList();
		return allEmployees;
	}
	
}

