package com.wirecard.myspring.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Cashier {
	private int id;
	private String name;
	private String password;
	private int age;
	private String address;
	private String role;
	private String birthPlace;
//	Date now = new Date();
//	private String birthDate = new SimpleDateFormat("MMMM dd, yyyy").format(now);
	
	public Cashier() {
		
	}
	
	public Cashier(int id, String name, String password) {
		this.id = id;
		this.name = name;
		this.password = password;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public int getId() {
		return id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}
	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getBirthPlace() {
		return birthPlace;
	}

	public void setBirthPlace(String birthPlace) {
		this.birthPlace = birthPlace;
	}

}
