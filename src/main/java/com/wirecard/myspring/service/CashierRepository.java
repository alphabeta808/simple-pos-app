package com.wirecard.myspring.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.wirecard.myspring.model.Cashier;

@Service
public class CashierRepository{

	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	public CashierRepository(DataSource dataSource) {
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}

	public CashierRepository() {
		
	}
	
	public void registration(Cashier cashier) {
		String sql = "INSERT INTO cashier(name, password, role, age, address, birth_place) values (?,?,?,?,?,?)";
		jdbcTemplate.update(sql, new Object[] {cashier.getName(), cashier.getPassword(), cashier.getRole(), cashier.getAge(), cashier.getAddress(), cashier.getBirthPlace()});
		return;
	}
	
	public boolean validate(String username, String password){
		boolean status = false;

		String sql = "SELECT * FROM cashier";
		List<Cashier> cashier = jdbcTemplate.query(sql, new CashierMapper());
		for(Cashier c: cashier) {
			if(username.equals(c.getName()) && password.equals(c.getPassword())) {
				status = true;
			}
		}
		return status;
	}
	
	private class CashierMapper implements RowMapper<Cashier>{
		@Override
		public Cashier mapRow(ResultSet rs, int rowNum) throws SQLException {
			Cashier cashier = new Cashier();
			cashier.setId(rs.getInt("id"));
			cashier.setName(rs.getString("name"));
			cashier.setPassword(rs.getString("password"));
			cashier.setRole(rs.getString("role"));
			cashier.setAge(rs.getInt("age"));
			cashier.setAddress(rs.getString("address"));
			cashier.setBirthPlace(rs.getString("birth_place"));
			return cashier;
		}
	}
}
