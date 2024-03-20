package com.wirecard.myspring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wirecard.myspring.model.Cashier;
import com.wirecard.myspring.model.Item;
import com.wirecard.myspring.model.Sale;
import com.wirecard.myspring.model.SaleItem;
import com.wirecard.myspring.service.CashierRepository;
import com.wirecard.myspring.service.ItemRepository;
import com.wirecard.myspring.service.SaleRepository;

@Controller
public class AppController {

	@Autowired
	ItemRepository itemRepo;

	@Autowired
	CashierRepository cashierRepo;

	@Autowired
	SaleRepository saleRepo;

//	Items controller section
	@RequestMapping(value = "/items/find/{itemCode}", method = RequestMethod.GET)
	public Item findByCode(@PathVariable("itemCode") String itemCode, Model model) {
		Item code = itemRepo.findByCode(itemCode);
		model.addAttribute("item", code);

		return code;
	}

	@RequestMapping(value = "/item/add", method = RequestMethod.POST)
	public String insertItem(@ModelAttribute("item") Item item) {
		itemRepo.insertItem(item);

		return "redirect:/items";
	}

	@RequestMapping(value = "/item/update", method = RequestMethod.POST)
	public String updateItem(@ModelAttribute("item") Item item) {
		itemRepo.updateItem(item);

		return "redirect:/items";
	}

	@RequestMapping(value = "/item/delete", method = RequestMethod.POST)
	public String deleteItem(@ModelAttribute("item") Item item) {
		itemRepo.deleteItem(item);

		return "redirect:/items";
	}

//	Dashboard controller section
	@RequestMapping(value = "/items", method = RequestMethod.GET)
	public String listOfItem(Model model, HttpServletRequest request) {
		if (request.getSession().getAttribute("cashier") != null) {
			model.addAttribute("itemList", itemRepo.findAll());

			return "items";
		} else {
			return "../../index";
		}
	}

	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboardPage(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		if (session.getAttribute("cashier") == null) {
			
			return "../../index";
		} else {
			model.addAttribute("itemList", itemRepo.findAll());
			return "dashboard";
		}
	}

	@RequestMapping(value = "/sales", method = RequestMethod.GET)
	public String ordersPage(HttpServletRequest request) {
		HttpSession session = request.getSession();
		System.out.println("IP - Addr ==>" + request.getRemoteAddr());
		System.out.println("IP - Host ==>" + request.getRemoteHost());
		System.out.println("IP - Port ==>" + request.getRemotePort());
		System.out.println("IP - User ==>" + request.getRemoteUser());


		System.out.println("IP - LocalAddr ==>" + request.getLocalAddr());
		System.out.println("IP - LocalName ==>" + request.getLocalName());
		System.out.println("IP - LocalPort ==>" + request.getLocalPort());


		Date now = new Date();
		String formattedDate = new SimpleDateFormat("hh:mm aa 'on' EEEE, MMMM dd, yyyy").format(now);
		request.setAttribute("date", formattedDate);
		
		List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");

		if (request.getSession().getAttribute("cashier") != null) {
			if(sale_session != null) {
				int total_sale = getTotalSale(sale_session);
				int tax = getTaxAmount(sale_session);
				session.setAttribute("totalSale", total_sale);
				session.setAttribute("tax", tax);
				session.setAttribute("totalSaleWithTax", total_sale + tax);
				request.setAttribute("sale_session", sale_session);
				return "sales";				
			} else {
				return "sales";	
			}
		} else {
			return "../../index";
		}
	}

	@RequestMapping(value = "/history", method = RequestMethod.GET)
	public String saleHistoryPage(Model model, HttpServletRequest request) {
		if (request.getSession().getAttribute("cashier") != null) {
			model.addAttribute("saleList", saleRepo.findAll());
			return "history";
		} else {
			return "../../index";
		}
	}
	
	@RequestMapping(value= "/history/detail/{sale_number}")
	public String saleHistoryDetailPage(@PathVariable("sale_number") String sale_number, Model model, HttpServletRequest request) {
		if(request.getSession().getAttribute("cashier") != null) {
			model.addAttribute("saleItemDetail", saleRepo.findBySaleNumber(sale_number));
			model.addAttribute("saleDetail", saleRepo.findSaleDetail(sale_number));
			return "sale-detail";
		}else {
			return "history";			
		}
	}

	@RequestMapping(value = "/user/validation", method = RequestMethod.GET)
	public String userValidation(@ModelAttribute("cashier") Cashier cashier, HttpServletRequest request) {
		HttpSession session = request.getSession();
		boolean cashierCeck = cashierRepo.validate(cashier.getName(), cashier.getPassword());
		session.setAttribute("cashier", cashier.getName());
		if (cashierCeck == true) {
			return "redirect:/dashboard";
		} else {
			return "../../index";
		}
	}

	@RequestMapping(value = "/user/registration", method = RequestMethod.GET)
	public String userRegistration(Cashier cashier) {
		cashierRepo.registration(cashier);

		return "../../index";
	}

	@RequestMapping(value = "/user/logout", method = RequestMethod.POST)
	public String logoutAction(HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");
		if(sale_session != null) {
			if (session.getAttribute("cashier") != null) {
				sale_session.clear();
				session.removeAttribute("totalSale");
				session.removeAttribute("tax");
				session.removeAttribute("totalSaleWithTax");
				session.removeAttribute("cashier");

				return "redirect:../../myspring";
			}
		} else {
			if (session.getAttribute("cashier") != null) {
				session.removeAttribute("totalSale");
				session.removeAttribute("tax");
				session.removeAttribute("totalSaleWithTax");
				session.removeAttribute("cashier");

				return "redirect:../../myspring";
			}

		}
		return "../../index";
	}

//	Sales Controller Section
	@RequestMapping(value = "/sales/add/{itemCode}", method = RequestMethod.GET)
	public String addOrderItem(@PathVariable("itemCode") String itemCode, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Item saleItem = itemRepo.findByCode(itemCode);
		Sale sale = new Sale();
		if (session.getAttribute("saleItem") == null) {
			List<Sale> saleList = new ArrayList<Sale>();
			sale.setItemCode(saleItem.getItemCode());
			sale.setDescription(saleItem.getDescription());
			sale.setType(saleItem.getType());
			sale.setPrice(saleItem.getPrice());
			sale.setQuantity(1);
			sale.setTaxable(saleItem.isTaxable());
			saleList.add(sale);
			session.setAttribute("saleItem", saleList);
		} else {
			List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");
			int index = isExisting(itemCode, sale_session);
			if (index == -1) {
				sale.setItemCode(saleItem.getItemCode());
				sale.setDescription(saleItem.getDescription());
				sale.setType(saleItem.getType());
				sale.setPrice(saleItem.getPrice());
				sale.setQuantity(1);
				sale.setTaxable(saleItem.isTaxable());
				sale_session.add(sale);
			} else {
				int newQuantity = sale_session.get(index).getQuantity() + 1;
				sale_session.get(index).setQuantity(newQuantity);
			}
		}
		return "redirect:/dashboard";
	}

	@RequestMapping(value = "/sales/decrease/{itemCode}", method = RequestMethod.GET)
	public String decreaseQuantity(@PathVariable("itemCode") String itemCode, HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");
		for (Sale s : sale_session) {
			if (s.getItemCode().equals(itemCode)) {
				if (s.getQuantity() <= 1) {
					sale_session.remove(sale_session.indexOf(s));
					return "redirect:/sales";
				} else {
					int newQuantity = s.getQuantity();
					newQuantity--;
					s.setQuantity(newQuantity);
				}
			}
		}
		return "redirect:/sales";
	}

	@RequestMapping(value = "/sales/increase/{itemCode}", method = RequestMethod.GET)
	public String increaseQuantity(@PathVariable("itemCode") String itemCode, HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");
		for (Sale s : sale_session) {
			if (s.getItemCode().equals(itemCode)) {
				int newQuantity = s.getQuantity();
				newQuantity++;
				s.setQuantity(newQuantity);
			}
		}
		return "redirect:/sales";
	}
	
	@RequestMapping(value = "/sales/pay-sale", method = RequestMethod.POST)
	private String paySaleItem(@ModelAttribute("sale") Sale sale,HttpServletRequest request) {
		HttpSession session = request.getSession();
		List<SaleItem> saleList = new ArrayList<SaleItem>();
		List<Sale> sale_session = (List<Sale>) session.getAttribute("saleItem");
		if(sale_session != null) {
			for(Sale s: sale_session) {
				SaleItem saleItem = new SaleItem();
				saleItem.setDescription(s.getDescription());
				saleItem.setType(s.getType());
				saleItem.setPrice(s.getPrice());
				saleItem.setQuantity(s.getQuantity());
				saleItem.setTaxable(s.isTaxable());
				saleItem.setTotal_price(s.getTotal_price());
				saleList.add(saleItem);
			}
			for(SaleItem s: saleList) {
				System.out.println(s.getDescription());
			}
			saleRepo.insertSale(sale, saleList);			
		}
		sale_session.clear();
		session.removeAttribute("totalSale");
		session.removeAttribute("tax");
		session.removeAttribute("totalSaleWithTax");
		
		return "redirect:/dashboard";
	}
	
	private int getTotalSale(List<Sale> sale) {
		int sum = 0;
		for (Sale s : sale) {
			sum += s.getTotal_price();
		}
		return sum;
	}

	private int getTaxAmount(List<Sale> sale) {
		int tax = 0;
		for (Sale s : sale) {
			if (s.isTaxable() == true) {
				tax += s.getTotal_price() * 0.1;
			}
		}
		return tax;
	}

	private int isExisting(String itemCode, List<Sale> sale) {
		for (int i = 0; i < sale.size(); i++) {
			if (sale.get(i).getItemCode().equalsIgnoreCase(itemCode)) {
				return i;
			}
		}
		return -1;
	}
}
