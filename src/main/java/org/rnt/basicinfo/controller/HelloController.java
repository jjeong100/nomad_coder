package org.rnt.basicinfo.controller;

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;

import org.rnt.com.controller.BaseController;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONArray;



@Controller
//@RequiredArgsConstructor
public class HelloController  extends BaseController {

    @GetMapping(value = "/hello")
//    @RequestMapping(value = "/hello.do")
//    @RequestMapping(path="/hello", method = RequestMethod.GET)
    @ResponseBody
//    public @ResponseBody List<String> Hello() {
     public	 ResponseEntity<List> Hello() {
    	System.out.println("■■■■■■■■■■■■■■ Hello!.");
//        return ResponseEntity.ok(Arrays.asList("서버 포트는 8890", "리액트 포트는 3000"));
    	List<String> test = Arrays.asList("서버 포트는 8890", "리액트 포트는 3000");

        HttpHeaders header = new HttpHeaders();
        header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
//        ResponseEntity.ok();
        return new ResponseEntity<>(Arrays.asList("서버 포트는 8890", "리액트 포트는 3000"), header, HttpStatus.OK);
    }
    
//    @GetMapping("/example")
//    @REQUESTMAPPING(PATH="/EXAMPLE", METHOD = REQUESTMETHOD.GET)
//    @RESPONSEBODY
//    PUBLIC RESPONSEENTITY<STRING> EXAMPLE(){
//      // MSG = {"NAME" : "홍길동"}
//      STRING MSG = "{ \" NAME \": \" 홍길동 \" }";
//      LIST<STRING> TEST = ARRAYS.ASLIST("서버 포트는 8890", "리액트 포트는 3000");
//
//      HTTPHEADERS HEADER = NEW HTTPHEADERS();
//      HEADER.ADD("CONTENT-TYPE", "APPLICATION/JSON; CHARSET=UTF-8");
//
//      RETURN NEW RESPONSEENTITY<>(MSG,HEADER,HTTPSTATUS.OK);
//    }
    
    @RequestMapping(path="/example", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<String> example(){
      // msg = {"name" : "홍길동"}
//      String msg = "{ \" name \": \" 홍길동 \" }";
      List<String> msg = Arrays.asList("서버 포트는 8890", "리액트 포트는 3000");
      System.out.println("■■■■■■■ : "+Arrays.toString(msg.toArray()));

      HttpHeaders header = new HttpHeaders();
      header.add("Content-Type", "application/json; charset=UTF-8");
      
    //JSONArray 객체 사용
      JSONArray result = JSONArray.fromObject(msg); //HashMap 등의 복잡한 자료형으로 덮어도 가능
      return new ResponseEntity<>(result.toString(),header,HttpStatus.OK);
    }
}
