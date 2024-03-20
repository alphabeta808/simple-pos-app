package com.wirecard.myspring.model;

public class Sale extends SaleItem{
	
	private String sale_number;
	private String cashier_name;
	private String date;
	private double tax_amount;
	private double total_sale;
	private int total_sale_tax;
	private String payment;
	private int cashPayment;
	private int qrisPayment;
	private int returnPayment;
	
	public Sale() {
	}
	
	public String getSale_number() {
		return sale_number;
	}
	public void setSale_number(String sale_number) {
		this.sale_number = sale_number;
	}
	
	public String getCashier_name() {
		return cashier_name;
	}
	public void setCashier_name(String cashier_name) {
		this.cashier_name = cashier_name;
	}
	
	public double getTax_amount() {
		return tax_amount;
	}

	public void setTax_amount(double tax_amount) {
		this.tax_amount = tax_amount;
	}

	public double getTotal_sale() {
		return total_sale;
	}

	public void setTotal_sale(double total_sale) {
		this.total_sale = total_sale;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	public int getTotal_sale_tax() {
		return total_sale_tax;
	}

	public void setTotal_sale_tax(int total_sale_tax) {
		this.total_sale_tax = total_sale_tax;
	}

	public String getPayment() {
		return payment;
	}

	public void setPayment(String payment) {
		this.payment = payment;
	}

	public int getCashPayment() {
		return cashPayment;
	}

	public void setCashPayment(int cashPayment) {
		this.cashPayment = cashPayment;
	}

	public int getQrisPayment() {
		return qrisPayment;
	}

	public void setQrisPayment(int qrisPayment) {
		this.qrisPayment = qrisPayment;
	}

	public int getReturnPayment() {
		return returnPayment;
	}

	public void setReturnPayment(int returnPayment) {
		this.returnPayment = returnPayment;
	}
	
}