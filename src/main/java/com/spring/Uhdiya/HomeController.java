package com.spring.Uhdiya;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.Uhdiya.cart.CartListDTO;
import com.spring.Uhdiya.cart.CartService;
import com.spring.Uhdiya.member.MemberDTO;
import com.spring.Uhdiya.product.ProductService;

@Controller
public class HomeController {
   
   @Autowired ProductService productService;
   @Autowired CartService cartService;
//   private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

   // localhost:8080/Uhdiya/
   @RequestMapping(value = {"/","/main"})
   public ModelAndView main(Locale locale, Model model,HttpServletRequest request, HttpServletResponse response
         ) throws Exception{
      ModelAndView mav = new ModelAndView();
      String cateL = "커피";
      
      Map productsMap = productService.listMain(cateL);
      mav.addObject("productsMap", productsMap);
      
      Map productsMap3 = productService.listMainDesc(cateL);
      mav.addObject("productsMap3", productsMap3);
      
      cateL="스틱커피";
      Map productsMap2 = productService.listMain(cateL);
      mav.addObject("productsMap2", productsMap2);
      
      mav.setViewName("main");
      HttpSession session = request.getSession();
      MemberDTO member = (MemberDTO) session.getAttribute("member");
      Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
      if(isLogOn!=null && member!=null) {
         String member_id =  member.getMember_id();
         int cartListCount = cartService.cartListCount(member_id);
         session.setAttribute("cartListCount",cartListCount);
      }
      return mav;
   }
   
   // About us
   @RequestMapping(value="/about")
   public String about(Locale local, Model model) {
      return "about";
   }
   
   // 회원 마이페이지
   @RequestMapping(value="/mypage")
   public String mypage(Locale local, Model model, HttpServletRequest request, HttpServletResponse response)throws Exception {
      response.setContentType("text/html; charset=utf-8");
      PrintWriter out = response.getWriter();
      HttpSession session = request.getSession();
      Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
      
      if(!isLogOn) {
         out.println("<script>");
         out.println("alert('로그인 후 이용가능합니다.");
         out.println("location.href='"+request.getContextPath()+"/member/login';");
         out.println("</script>");
         return null;
      }
      return "mypage";
   }
   
   // 관리자 페이지
   @RequestMapping(value="/adminpage")
   public String adminpage(Locale local, Model model, HttpServletRequest request, HttpServletResponse response)throws Exception {
      response.setContentType("text/html; charset=utf-8");
      PrintWriter out = response.getWriter();
      HttpSession session = request.getSession();
      Boolean isLogOn = (Boolean) session.getAttribute("isLogOn");
      MemberDTO member = (MemberDTO) session.getAttribute("member");
      String member_id = member.getMember_id();
      
      if(!isLogOn || !(member_id.equals("admin"))) {
         out.println("<script>");
         out.println("alert('로그인 후 이용가능합니다.");
         out.println("location.href='"+request.getContextPath()+"/member/login';");
         out.println("</script>");
         return null;
      }
      return "adminpage";
   }
}