package com.wirecard.myspring.model;

public class Item {
	private String itemCode;
	private String description;
	private String type;
	private int price;
	private boolean taxable = true;

	public Item() {
	}
	
	public Item(String itemCode, String description, String type,  int price, boolean taxable){
		this.itemCode = itemCode;
		this.description = description;
		this.type = type;
		this.price = price;
		this.taxable = taxable;
	}
	
	public String getItemCode() {
		return itemCode;
	}
	
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	public int getPrice() {
		return price;
	}
	
	public void setPrice(int price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}

	public boolean isTaxable() {
		return taxable;
	}
	
	public void setTaxable(boolean taxable) {
		this.taxable = taxable;
	}

	@Override
	public String toString() {
		return "Item [item_code=" + itemCode + ", description=" + description + ", type=" + type
				+ ", price=" + price + ", taxable=" + taxable + "]";
	}
}
