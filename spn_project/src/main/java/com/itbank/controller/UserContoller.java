package com.itbank.controller;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.component.HashComponent;
import com.itbank.model.UserDTO;
import com.itbank.service.UserService;

@Controller
@RequestMapping("/user")
public class UserContoller{
	
	@Autowired private UserService userService;
	@Autowired private HashComponent hashcomponent;
	
	@Value("classpath:agreement/agreement1.txt")
	private Resource agreement1;
	
	@Value("classpath:agreement/agreement2.txt")
	private Resource agreement2;
	
	@Value("classpath:agreement/agreement3.txt")
	private Resource agreement3;
	
	
	@GetMapping("/login")
	public void login(){}
	
	@PostMapping("/login")
	//로그인후 세션에 user 라는 이름으로 600초간 등록. 
	public ModelAndView login(UserDTO dto, String url, HttpSession session) {
		
		String pwd = hashcomponent.getHash(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
				
		UserDTO user = userService.login(dto);
		if(user == null) {
			System.out.println(user);
			ModelAndView  mav = new ModelAndView("/errorpage");
			String msg = "일치하는 아이디와 비밀번호가 존재하지 않습니다.";
			mav.addObject("msg",msg);
			return mav;
		}	
		String RedirectUrl = (url == null ? "/home" : url);
		ModelAndView mav =  new ModelAndView(RedirectUrl);
			session.setAttribute("user", user);
			session.setMaxInactiveInterval(600);
		return mav;
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}


	
	@GetMapping("join")
	public ModelAndView join() throws IOException {
		ModelAndView mav = new ModelAndView();
		String[] agreement = {"agreement1","agreement2","agreement3"};
		
		File[] f = {agreement1.getFile(),agreement2.getFile(),agreement3.getFile()};
		
		for(int i=0; i < f.length; i ++) {
			Scanner sc = new Scanner(f[i]);
			 	agreement[i] = "";
			while(sc.hasNextLine()) {
				agreement[i] += sc.nextLine();
				agreement[i] += "\n";
				mav.addObject("agreement"+(i+1),agreement[i]);
			}
			sc.close();
		}
				
		return mav;
	}
	
	@PostMapping("/join")
	public String join(UserDTO dto, HttpSession session) {
		
		String pwd = hashcomponent.getHash(dto.getUser_pwd());
		dto.setUser_pwd(pwd);
		
		int row = userService.join(dto);
		System.out.println(row == 1? "추가성공":"추가 실패");
		
		return "redirect:/";
	}
	
	@GetMapping("/mypage")							
	public String board(HttpSession session) {		
		if(session.getAttribute("login") == null) {	
			return "redirect:/user/login";				
		}
		return "/user/mypage";	//
	}
}
