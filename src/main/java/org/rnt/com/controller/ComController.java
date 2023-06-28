package org.rnt.com.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import javax.activation.MimetypesFileTypeMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.rnt.com.util.ZPLConverter;
import org.rnt.com.util.ZebraPrinter;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

@Controller
public class ComController extends BaseController {
    protected Log log = LogFactory.getLog(this.getClass());
    
    
    @RequestMapping(value = "/makeListTypeExcel.do", method = RequestMethod.POST)
    @ResponseBody
    public void makeListTypeExcel(HttpServletRequest req, HttpServletResponse resp, HttpSession session
            , @RequestBody String reqBody) throws IOException, WriteException {
//        logger.info("[makeListTypeExcel]");
        
        String folderName = req.getSession().getServletContext().getRealPath("excelTemp");
        String realFileName = "temp"+UUID.randomUUID()+".xls";
        String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
        String convertFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".csv";
        
        // make upload folder and temp excel file.
        File folder = new File(folderName);
        if (!folder.exists()) {
            folder.mkdir();
        }
        File file = new File(folder, realFileName);
        
        // declare workbook and sheet instance.
        WritableWorkbook workbook = null;
        WritableSheet sheet = null;
        
        workbook = Workbook.createWorkbook(file);
        sheet = workbook.createSheet("Sheet", 0);
        
        //header style
        WritableCellFormat titleFormat  = new WritableCellFormat(

            new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
                                10,                             //폰트 크기 
                                WritableFont.BOLD,              //Bold 스타일
                                false,                          //이탤릭체여부
                                UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
                                Colour.WHITE,                   //폰트 색
                                ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
        );
        
        // 셀 가로정열(좌/우/가운데설정가능)
        titleFormat.setAlignment(Alignment.CENTRE);
        // 보더와 보더라인스타일 설정
        titleFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
        // 배경색 설정
        titleFormat.setBackground(Colour.GRAY_50);
        
        //body style
        WritableCellFormat bodyFormat  = new WritableCellFormat(

                new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
                                    10,                             //폰트 크기 
                                    WritableFont.NO_BOLD,           //Bold 스타일
                                    false,                          //이탤릭체여부
                                    UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
                                    Colour.BLACK,                   //폰트 색
                                    ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
            );
            
        // 보더와 보더라인스타일 설정
        bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
        
        // parse requested data (json type)
        JsonArray reqJsonArray = null;
        if (reqBody != null && reqBody.trim().length() != 0) {
            JsonParser jsonParser = new JsonParser();
            reqJsonArray = jsonParser.parse(reqBody).getAsJsonArray();
        }
//        logger.info("reqJsonArray="+reqJsonArray.toString());
        
        // set excel headers
        List<String> keys = new ArrayList<String>();
        for (Entry<String, JsonElement> entry : reqJsonArray.get(0).getAsJsonObject().entrySet()) {
            keys.add(entry.getKey());
            System.out.println(entry.getKey());
        }
        
        //cell 넓이 계산시 사용
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        // fill excel file data
        for (int rowIndex = 0 ; rowIndex < reqJsonArray.size() ; rowIndex++) {
            JsonObject jObj = reqJsonArray.get(rowIndex).getAsJsonObject();
            for (int columnIndex = 0 ; columnIndex < keys.size() ; columnIndex++) {
                try {
                    if(rowIndex == 0) {
                        sheet.addCell(new Label(columnIndex, rowIndex, jObj.get(keys.get(columnIndex)).getAsString(), titleFormat));
                    } else {
                        sheet.addCell(new Label(columnIndex, rowIndex, jObj.get(keys.get(columnIndex)).getAsString(), bodyFormat));
                    }
                    if(map.containsKey(columnIndex)){   
                        if(map.get(columnIndex).intValue() < jObj.get(keys.get(columnIndex)).getAsString().length()) {
                            map.put(columnIndex, jObj.get(keys.get(columnIndex)).getAsString().length());                                               
                        }
                    } else {
                        map.put(columnIndex, jObj.get(keys.get(columnIndex)).getAsString().length());
                    }
                } catch (RowsExceededException e) {
                    e.printStackTrace();
                } catch (WriteException e) {
                    e.printStackTrace();
                }
            }
        }
        //cell 넓이
        for( int key : map.keySet() ) {
            sheet.setColumnView(key, map.get(key)+10);
        }
        
        workbook.write();
        workbook.close();

        JsonObject resultJson = new JsonObject();
        resultJson.addProperty("folderName", folderName);
        resultJson.addProperty("realFileName", realFileName);
        resultJson.addProperty("saveFileName", saveFileName);

        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(resultJson.toString());
    }
    
    @RequestMapping(value = "/makeListTypeCsv.do", method = RequestMethod.POST)
    @ResponseBody
    public void makeListTypeCsv(HttpServletRequest req, HttpServletResponse resp, HttpSession session
    		, @RequestBody String reqBody) throws IOException, WriteException {
//        logger.info("[makeListTypeExcel]");
    	
    	String folderName = req.getSession().getServletContext().getRealPath("excelTemp");
    	String realFileName = "temp"+UUID.randomUUID()+".xls";
    	String saveFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".xls";
    	String convertFileName = new SimpleDateFormat("yyyyMMdd").format(new Date()) + ".csv";
    	
    	// make upload folder and temp excel file.
    	File folder = new File(folderName);
    	if (!folder.exists()) {
    		folder.mkdir();
    	}
    	File file = new File(folder, realFileName);
    	
    	// declare workbook and sheet instance.
    	WritableWorkbook workbook = null;
    	WritableSheet sheet = null;
    	
    	workbook = Workbook.createWorkbook(file);
    	sheet = workbook.createSheet("Sheet", 0);
    	
    	//header style
    	WritableCellFormat titleFormat  = new WritableCellFormat(
    			
    			new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
    					10,                             //폰트 크기 
    					WritableFont.BOLD,              //Bold 스타일
    					false,                          //이탤릭체여부
    					UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
    					Colour.WHITE,                   //폰트 색
    					ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
    			);
    	
    	// 셀 가로정열(좌/우/가운데설정가능)
    	titleFormat.setAlignment(Alignment.CENTRE);
    	// 보더와 보더라인스타일 설정
    	titleFormat.setBorder(Border.ALL, BorderLineStyle.MEDIUM);
    	// 배경색 설정
    	titleFormat.setBackground(Colour.GRAY_50);
    	
    	//body style
    	WritableCellFormat bodyFormat  = new WritableCellFormat(
    			
    			new WritableFont (  WritableFont.ARIAL,             //폰트 타입.Arial 외 별다른건 없는듯 하다.
    					10,                             //폰트 크기 
    					WritableFont.NO_BOLD,           //Bold 스타일
    					false,                          //이탤릭체여부
    					UnderlineStyle.NO_UNDERLINE,    //밑줄 스타일
    					Colour.BLACK,                   //폰트 색
    					ScriptStyle.NORMAL_SCRIPT)      //스크립트 스타일
    			);
    	
    	// 보더와 보더라인스타일 설정
    	bodyFormat.setBorder(Border.ALL, BorderLineStyle.THIN);
    	
    	// parse requested data (json type)
    	JsonArray reqJsonArray = null;
    	if (reqBody != null && reqBody.trim().length() != 0) {
    		JsonParser jsonParser = new JsonParser();
    		reqJsonArray = jsonParser.parse(reqBody).getAsJsonArray();
    	}
//        logger.info("reqJsonArray="+reqJsonArray.toString());
    	
    	// set excel headers
    	List<String> keys = new ArrayList<String>();
    	for (Entry<String, JsonElement> entry : reqJsonArray.get(0).getAsJsonObject().entrySet()) {
    		keys.add(entry.getKey());
    		System.out.println(entry.getKey());
    	}
    	
    	//cell 넓이 계산시 사용
    	Map<Integer, Integer> map = new HashMap<Integer, Integer>();
    	// fill excel file data
    	for (int rowIndex = 0 ; rowIndex < reqJsonArray.size() ; rowIndex++) {
    		JsonObject jObj = reqJsonArray.get(rowIndex).getAsJsonObject();
    		for (int columnIndex = 0 ; columnIndex < keys.size() ; columnIndex++) {
    			try {
    				if(rowIndex == 0) {
    					sheet.addCell(new Label(columnIndex, rowIndex, jObj.get(keys.get(columnIndex)).getAsString(), titleFormat));
    				} else {
    					sheet.addCell(new Label(columnIndex, rowIndex, jObj.get(keys.get(columnIndex)).getAsString(), bodyFormat));
    				}
    				if(map.containsKey(columnIndex)){   
    					if(map.get(columnIndex).intValue() < jObj.get(keys.get(columnIndex)).getAsString().length()) {
    						map.put(columnIndex, jObj.get(keys.get(columnIndex)).getAsString().length());                                               
    					}
    				} else {
    					map.put(columnIndex, jObj.get(keys.get(columnIndex)).getAsString().length());
    				}
    			} catch (RowsExceededException e) {
    				e.printStackTrace();
    			} catch (WriteException e) {
    				e.printStackTrace();
    			}
    		}
    	}
    	//cell 넓이
    	for( int key : map.keySet() ) {
    		sheet.setColumnView(key, map.get(key)+10);
    	}
    	
    	workbook.write();
    	workbook.close();
    	
    	File csvFile = new File(folder, convertFileName);
    	convert(file, csvFile);
    	
    	JsonObject resultJson = new JsonObject();
    	resultJson.addProperty("folderName", folderName);
    	resultJson.addProperty("realFileName", convertFileName);
    	resultJson.addProperty("saveFileName", convertFileName);
    	
    	resp.setContentType("application/json");
    	resp.setCharacterEncoding("UTF-8");
    	resp.getWriter().write(resultJson.toString());
    }
    
 // File Download
    @RequestMapping(value="/downloadFile.do", method = RequestMethod.GET)
    public void downloadFile(HttpServletRequest request, HttpServletResponse response
            , @RequestParam(value="folderName", required = true) String folderName
            , @RequestParam(value="realFileName", required = true) String realFileName
            , @RequestParam(value="saveFileName", required = true) String saveFileName) throws Exception {
        log.info("into downloadFile");
        log.info("folderName="+folderName);
        log.info("realFileName="+realFileName);
        log.info("saveFileName="+saveFileName);
        // File Operation
        InputStream input = null;
        OutputStream output = null;
        try {
            File targetDir = new File(folderName);
            
            File file  = new File(targetDir, realFileName);
            log.info("file info ===>"+ file.toString());
            
            input = new FileInputStream(file);
            output = response.getOutputStream();
            
            String contentDisposition = getDisposition(saveFileName, getBrowser(request));
            response.addHeader("Content-disposition", contentDisposition);
            response.setHeader("Content-Length", String.valueOf(file.length()));
            response.setContentType(new MimetypesFileTypeMap().getContentType(file));
            FileCopyUtils.copy(input, output);
            
            output.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (input != null) { try { input.close(); } catch (IOException ioe) { /* */ } }
            if (output != null) { try { output.close(); } catch (IOException ioe) { /* */ } }
        }
        
        log.info("saveFileName ===>"+saveFileName);
    }
    
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header.indexOf("MSIE") > -1) {
            return "MSIE";
        } else if (header.indexOf("Chrome") > -1) {
            return "Chrome";
        } else if (header.indexOf("Opera") > -1) {
            return "Opera";
        }
        return "Firefox";
    }
    
    // 브라우저 타입에 따라 File Name Encoding을 다르게 구성함.
    private String getDisposition(String filename, String browser) throws Exception {
        String dispositionPrefix = "attachment;filename=";
        String encodedFilename = null;
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, "UTF-8"));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else {
            throw new RuntimeException("Not supported browser");
        }
        
        return dispositionPrefix + encodedFilename;
    }
    
    //라벨 이미지 변환 및 출력
    @RequestMapping(value = "/labelImageConvertPrint.do", method = RequestMethod.POST)
    @ResponseBody
    public void ImageConversion(HttpServletRequest req, HttpServletResponse resp,
            @RequestParam(value="IpAdress", required = false, defaultValue = "192.168.0.124") String IpAdress,
            @RequestParam(value="Port", required = false, defaultValue = "6101") int Port,
            @RequestParam(value="Count", required = false, defaultValue = "1") int Count,
            @RequestParam(value="imageData", required = false) String dataUrl
            ) throws Exception{
        int result = 0;
        String resultMessage = " 장 출력 되었습니다.";
        System.out.println("Count ==>" + Count);
        /*if(printer.contentEquals("zebra")) {*/
            ZPLConverter zplc = new ZPLConverter();
            String zplCode = zplc.dataUrl2Zpl(dataUrl);
            result = new ZebraPrinter(zplCode, IpAdress, Port, Count).print();
        /*}else if(printer.contentEquals("tsc")) {
            result = new TSCPrinter(dataUrl, IpAdress, Port, Count).print();
        }*/
        
        resultMessage = result + resultMessage;
        
        JsonObject resultJson = new JsonObject();
        resultJson.addProperty("result", result);
        resultJson.addProperty("resultMessage", resultMessage);
        
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(resultJson.toString());
    }
    
    //라벨 이미지 변환 및 출력
    @RequestMapping(value = "/labelMultiImageConvertPrint.do", method = RequestMethod.POST)
    @ResponseBody
    public void labelMultiImageConvertPrint(HttpServletRequest req, HttpServletResponse resp,
    		@RequestParam(value="IpAdress", required = false, defaultValue = "192.168.0.124") String IpAdress,
    		@RequestParam(value="Port", required = false, defaultValue = "6101") int Port,
    		@RequestParam(value="Count", required = false, defaultValue = "1") int Count,
    		@RequestParam(value="imageData[]", required = false) List<String> imageData
    		) throws Exception{
    	int result = 0;
    	String resultMessage = " 장 출력 되었습니다.";
    	System.out.println("Count ==>" + Count);
    	
    	for(int i=0; i<imageData.size(); i++) {
    		ZPLConverter zplc = new ZPLConverter();
    		String zplCode = zplc.dataUrl2Zpl(imageData.get(i));
    		result += new ZebraPrinter(zplCode, IpAdress, Port, Count).print();
    	}
    	
    	resultMessage = result + resultMessage;
    	
    	JsonObject resultJson = new JsonObject();
    	resultJson.addProperty("result", result);
    	resultJson.addProperty("resultMessage", resultMessage);
    	
    	resp.setContentType("application/json");
    	resp.setCharacterEncoding("UTF-8");
    	resp.getWriter().write(resultJson.toString());
    }
    
    public void convert(File inputFile, File outputFile) {
    	// For storing data into CSV files
        StringBuffer data = new StringBuffer();

        try {
            FileOutputStream fos = new FileOutputStream(outputFile);
            // Get the workbook object for XLSX file
            FileInputStream fis = new FileInputStream(inputFile);
            HSSFWorkbook workbook = new HSSFWorkbook(fis);

            // Get first sheet from the workbook

            int numberOfSheets = workbook.getNumberOfSheets();
            Row row;
            Cell cell;
            // Iterate through each rows from first sheet

            for (int i = 0; i < numberOfSheets; i++) {
                Sheet sheet = workbook.getSheetAt(0);
                Iterator<Row> rowIterator = sheet.iterator();

                while (rowIterator.hasNext()) {
                    row = rowIterator.next();
                    // For each row, iterate through each columns
                    Iterator<Cell> cellIterator = row.cellIterator();
                    while (cellIterator.hasNext()) {

                        cell = cellIterator.next();
                        
                        switch (cell.getCellType()) {
                        case Cell.CELL_TYPE_BOOLEAN:
                            data.append(cell.getBooleanCellValue() + ",");

                            break;
                        case Cell.CELL_TYPE_NUMERIC:
                            data.append(cell.getNumericCellValue() + ",");

                            break;
                        case Cell.CELL_TYPE_STRING:
                            data.append(cell.getStringCellValue() + ",");
                            break;

                        case Cell.CELL_TYPE_BLANK:
                            data.append("" + ",");
                            break;
                        default:
                            data.append(cell + ",");

                        }
                    }
                    
                    data.deleteCharAt(data.lastIndexOf(","));
                    data.append('\n'); // appending new line after each row
                }

            }
            //fos.write(data.toString().getBytes());
            //fos.close();
            
            Writer writer = null;
            writer = new OutputStreamWriter(fos, "MS949");
            writer.write(data.toString());
            writer.close();
            fos.close();
            
        } catch (Exception ioe) {
            ioe.printStackTrace();
        }
    }
}
