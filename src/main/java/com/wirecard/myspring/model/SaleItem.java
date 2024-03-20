package com.wirecard.myspring.model;

public class SaleItem extends Item{
	private String sale_number;
	private int quantity;
	private int total_price;

	public String getSale_number() {
		return sale_number;
	}
	public void setSale_number(String sale_number) {
		this.sale_number = sale_number;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotal_price() {
		return total_price = quantity * super.getPrice();
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}

}
