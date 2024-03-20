package com.wirecard.myspring.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.wirecard.myspring.model.Item;
import com.wirecard.myspring.model.Sale;
import com.wirecard.myspring.model.SaleItem;



@Service
public class SaleRepository {

	private JdbcTemplate jdbcTemplate;

	@Autowired
	public SaleRepository(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public SaleRepository() {
	}
	
	public void insertSale(Sale sale, List<SaleItem> saleList) {
		Sale newSale = new Sale();
		if(sale.getCashPayment() > 0) {
			newSale.setPayment("Cash");
		} else {
			newSale.setPayment("Qris");
		}
		
		String saleQuery = "INSERT INTO sale(sale_number, cashier_name, date, total_sale, tax_amount, total_sale_tax, payment, pay_with_cash, pay_with_qris, return_payment) values (?,?,?,?,?,?,?,?,?,?)";
		jdbcTemplate.update(saleQuery, new Object[] {
				sale.getSale_number(), 
				sale.getCashier_name(), 
				sale.getDate(), 
				sale.getTotal_sale(), 
				sale.getTax_amount(), 
				sale.getTotal_sale_tax(),
				newSale.getPayment(), 
				sale.getCashPayment(), 
				sale.getQrisPayment(), 
				sale.getReturnPayment()});

		
		String saleItemQuery = "INSERT INTO sale_item2(sale_number, item_name, type, price, quantity, total_price, taxable) values (?,?,?,?,?,?,?)";
		jdbcTemplate.batchUpdate(saleItemQuery, new BatchPreparedStatementSetter() {

//			int id = 1;
			
	        @Override
	        public void setValues(PreparedStatement ps, int i)
	            throws SQLException {

	            SaleItem saleItem = saleList.get(i);
	            ps.setString(1, sale.getSale_number());
	            ps.setString(2, saleItem.getDescription());
	            ps.setString(3, saleItem.getType());
	            ps.setInt(4, saleItem.getPrice());
	            ps.setInt(5, saleItem.getQuantity());
	            ps.setInt(6, saleItem.getTotal_price());
	            if(saleItem.isTaxable() == true) {
	            	ps.setInt(7, 1);	            	
	            }else {
	            	ps.setInt(7, 0);
	            }
	        }

	        @Override
	        public int getBatchSize() {
	            return saleList.size();
	        }
	    });
		return;
	}
	
	public List<Sale> findAll(){
		String sqlQuery = "SELECT * FROM sale";
		List<Sale> saleList = jdbcTemplate.query(sqlQuery, new SaleMapper());
		return saleList;
	}

	public List<Sale> findSaleDetail(String sale_number) {
		String sqlQuery = "SELECT * FROM sale WHERE sale_number = ?";
		List<Sale> saleDetail = jdbcTemplate.query(sqlQuery, new Object[] {sale_number}, new SaleMapper());
		return saleDetail;
	}
	
	public List<SaleItem> findBySaleNumber(String sale_number) {
		String sqlQuery = "SELECT * FROM sale_item2 WHERE sale_number = ?";
		List<SaleItem> saleItem = jdbcTemplate.query(sqlQuery, new Object[] {sale_number}, new SaleItemMapper());
		return saleItem;
	}
	
	private class SaleMapper implements RowMapper<Sale> {

		@Override
		public Sale mapRow(ResultSet rs, int rowNum) throws SQLException {
			Sale sale = new Sale();
			sale.setSale_number(rs.getString("sale_number"));
			sale.setCashier_name(rs.getString("cashier_name"));
			sale.setDate(rs.getString("date"));
			sale.setTotal_sale(rs.getDouble("total_sale"));
			sale.setTax_amount(rs.getDouble("tax_amount"));
			sale.setTotal_sale_tax(rs.getInt("total_sale_tax"));
			if(rs.getInt("pay_with_cash")>0) {
				sale.setPayment("Cash");
				sale.setCashPayment(rs.getInt("pay_with_cash"));
				sale.setQrisPayment(0);
			} else {
				sale.setPayment("Qris");
				sale.setQrisPayment(rs.getInt("pay_with_qris"));
				sale.setCashPayment(0);
			}
			sale.setReturnPayment(rs.getInt("return_payment"));
			return sale;
		}
	}
	
	private class SaleItemMapper implements RowMapper<SaleItem> {
		
		@Override
		public SaleItem mapRow(ResultSet rs, int rowNum) throws SQLException {
			SaleItem saleItem = new SaleItem();
			saleItem.setSale_number(rs.getString("sale_number"));
			saleItem.setDescription(rs.getString("item_name"));
			saleItem.setType(rs.getString("type"));
			saleItem.setPrice(rs.getInt("price"));
			saleItem.setQuantity(rs.getInt("quantity"));
			saleItem.setTotal_price(rs.getInt("total_price"));
			if (rs.getInt("taxable") == 1) {
				saleItem.setTaxable(true);
			} else {
				saleItem.setTaxable(false);
			}
			return saleItem;
		}
	}
	
//	public void insertSale(String sale_number, String casier, String date, int total_sale) {
//		String username = "root";
//		String password = "root";
//		String jdbcUrl = "jdbc:mysql://localhost:3306/simple_pos_db?characterEncoding=utf8";
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
//
//			String insertSale = "INSERT INTO sale(sale_number, cashier_name, date, total_sale) values (?,?,?,?)";
//			PreparedStatement stm = conn.prepareStatement(insertSale);
//
//			stm.setString(1, sale_number);
//			stm.setString(2, casier);
//			stm.setString(3, date);
//			stm.setDouble(4, total_sale);
//
//			stm.executeUpdate();
//
//			stm.close();
//			conn.close();
//		} catch (SQLException e) {
//			System.out.println(e.getMessage());
//		} catch (ClassNotFoundException e) {
//			e.getStackTrace();
//			System.out.println(e.getMessage());
//		}
//	}
//
//	public boolean insertSaleDetail(Sale sale) {
//		boolean result = false;
//		String username = "root";
//		String password = "root";
//		String jdbcUrl = "jdbc:mysql://localhost:3306/simple_pos_db?characterEncoding=utf8";
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//			Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
//
//			String insertSaleDetail = "INSERT INTO sale_detail(item_name, type, price, quantity, total_price, taxable, sale_number) values (?,?,?,?,?,?,?)";
//			PreparedStatement stm1 = conn.prepareStatement(insertSaleDetail);
//			System.out.println("from repo " + sale.getDescription());
//			stm1.setString(1, sale.getDescription());
//			stm1.setString(2, sale.getType());
//			stm1.setInt(3, sale.getPrice());
//			stm1.setInt(4, sale.getQuantity());
//			stm1.setInt(5, sale.getTotal_price());
//			if (sale.isTaxable() == true) {
//				stm1.setInt(6, 1);
//			} else {
//				stm1.setInt(6, 0);
//			}
//			stm1.setString(7, sale.getSale_number());
//
//			stm1.executeUpdate();
//
//			result = true;
//
//			stm1.close();
//			conn.close();
//		} catch (SQLException e) {
//			System.out.println(e.getMessage());
//		} catch (ClassNotFoundException e) {
//			e.getStackTrace();
//			System.out.println(e.getMessage());
//		}
//		return result;
//	}

//	public List<Sale> findAllSale() {
//		List<Sale> sale_list = new ArrayList<Sale>();
//		String username = "root";
//		String password = "root";
//		String jdbcUrl = "jdbc:mysql://localhost:3306/simple_pos_db?characterEncoding=utf8";
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//
//			Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
//			String sqlQuery = "SELECT * FROM sale";
//
//			Statement stm = conn.createStatement();
//			ResultSet rs = stm.executeQuery(sqlQuery);
//
//			while (rs.next()) {
//				Sale s = new Sale();
//				s.setSale_number(rs.getString("sale_number"));
//				s.setCashier_name(rs.getString("cashier_name"));
//				s.setDate(rs.getString("date"));
//				s.setTotal_sale(rs.getDouble("total_sale"));
//				sale_list.add(s);
//			}
//			if (conn != null) {
//				System.out.println("DB Connected!");
//			}
//		} catch (SQLException e) {
//			e.printStackTrace();
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//		return sale_list;
//	}
//
//	public List<Sale> findSale(String sale_number) {
//		List<Sale> sale_list = new ArrayList<Sale>();
//		String username = "root";
//		String password = "root";
//		String jdbcUrl = "jdbc:mysql://localhost:3306/simple_pos_db?characterEncoding=utf8";
//
//		try {
//			Class.forName("com.mysql.cj.jdbc.Driver");
//
//			Connection conn = DriverManager.getConnection(jdbcUrl, username, password);
//			String sql = "SELECT * FROM sale_detail ";
//
//			Statement stm = conn.createStatement();
//			ResultSet rs = stm.executeQuery(sql);
//
//			while (rs.next()) {
//				Sale s = new Sale();
//				if (sale_number.equals(rs.getString("sale_number"))) {
//					s.setSale_number(sale_number);
//					s.setDescription(rs.getString("item_name"));
//					s.setType(rs.getString("type"));
//					s.setPrice(rs.getInt("price"));
//					s.setQuantity(rs.getInt("quantity"));
//					if (rs.getInt("taxable") == 1) {
//						s.setTaxable(true);
//					} else {
//						s.setTaxable(false);
//					}
//					s.setTotal_price(rs.getInt("total_price"));
//					sale_list.add(s);
//				}
//			}
//
//		} catch (SQLException e) {
//			System.out.println(e.getMessage());
//		} catch (ClassNotFoundException e) {
//			e.getStackTrace();
//			System.out.println(e.getMessage());
//		}
//
//		return sale_list;
//	}
}
