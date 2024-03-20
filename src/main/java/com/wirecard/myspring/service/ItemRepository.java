package com.wirecard.myspring.service;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.wirecard.myspring.model.Item;

@Service
public class ItemRepository{
	
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public ItemRepository(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public ItemRepository() {
		
	}
	
	public List<Item> findAll(){
		String sqlQuery = "SELECT * FROM items";
		List<Item> itemList = jdbcTemplate.query(sqlQuery, new ItemMapper());
		return itemList;
	}
	
	public Item findByCode(String itemCode) {
		String sqlQuery = "SELECT * FROM items WHERE item_code = ?";
		Item item = jdbcTemplate.queryForObject(sqlQuery, new Object[] {itemCode}, new ItemMapper());
		return item;
	}
	
	public void insertItem(Item item) {
		String sql = "INSERT INTO items(item_code, item_name, type, price, taxable) values (?,?,?,?,?)";
		jdbcTemplate.update(sql, new Object[] {item.getItemCode(), item.getDescription(), item.getType(), item.getPrice(), item.isTaxable()});
		return;
	}	
	
	public void updateItem(Item item) {
		String sql = "UPDATE items SET item_name = ?, type = ?, price = ?, taxable = ? WHERE item_code = ?";	
		jdbcTemplate.update(sql, new Object[] {item.getDescription(), item.getType(), item.getPrice(), item.isTaxable(), item.getItemCode()});
		return;
	}
	
	public void deleteItem(Item item) {
		String sql = "DELETE FROM items WHERE item_code = ?";
		jdbcTemplate.update(sql, item.getItemCode());
		return;
	}
	
	private class ItemMapper implements RowMapper<Item>{

		@Override
		public Item mapRow(ResultSet rs, int rowNum) throws SQLException {
			Item item = new Item();
			item.setItemCode(rs.getString("item_code"));
			item.setDescription(rs.getString("item_name"));
			item.setType(rs.getString("type"));
			item.setPrice(rs.getInt("price"));
			if(rs.getInt("taxable") == 1) {
				item.setTaxable(true);				
			} else {
				item.setTaxable(false);
			}
			return item;
		}
		
	}	
}
