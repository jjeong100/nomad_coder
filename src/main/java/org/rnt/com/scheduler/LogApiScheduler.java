package org.rnt.com.scheduler;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.rnt.com.GlvConst;
import org.rnt.com.entity.service.UserHistoryService;
import org.rnt.com.entity.vo.UserHistoryVO;
import org.rnt.com.service.ProPertyService;
import org.rnt.com.vo.RtnVO;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class LogApiScheduler {
	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "userHistoryService")
	private UserHistoryService userHistoryService;

	@Resource(name = "proPertyService")
	private ProPertyService proPertyService;
	
	/**
	 * cron = 초, 분, 시, 일, 월, 요일, 년
	 * 
	 * @return
	 */
	@Scheduled(cron = "0 0 17 * * MON-FRI")
	public void callLogApi() {
//		log.debug("Scheduler createTodayHistory start");
		
		try {
			UserHistoryVO userHistoryVo = new UserHistoryVO();
			RtnVO rtn = userHistoryService.selectTodayHistoryList(userHistoryVo);
			
			if( rtn.getObj() != null ) {
				List<UserHistoryVO> list = (List<UserHistoryVO>) rtn.getObj();
				
				if( list.size() == 0 ) {
					userHistoryService.createTodayHistory(userHistoryVo);
				}
			}
			
		} catch (Exception e) {
			log.debug("####################		createTodayHistory Exception		####################");
			log.debug(e.getMessage());
		}
		
//		log.debug("Scheduler createTodayHistory end");
	}
	
	/**
	 * cron 매1분마다 실행 = 초, 분, 시, 일, 월, 요일, 년
	 * 
	 * @return
	 */
	@Scheduled(cron = "0 0/1 * * * MON-FRI")
	public void callLogApiTodayMinute() {
		// 프로퍼티가 없으면 스케줄 중지(resource-real에만 설정, resource-dev에는 파라미터 값을 비워둬야함.)
		if( StringUtils.isEmpty(proPertyService.getLogApiKey()) ) {
			return;
		}
		
//		log.debug("Scheduler callLogApiTodayMinute start");
		
		try {
			UserHistoryVO userHistoryVo = new UserHistoryVO();
			userHistoryVo.setSearchNotInterfaceYn("Y");
			
			RtnVO rtn = userHistoryService.selectTodayHistoryList(userHistoryVo);
			
			if( rtn.getObj() != null ) {
				List<UserHistoryVO> objList = (List<UserHistoryVO>) rtn.getObj();
				
				String rtnString = "";
				for (UserHistoryVO tempVo : objList) {
					rtnString = sendREST(proPertyService.getLogApiUrl(), getParamString(tempVo));
					
					UserHistoryVO updateVo = new UserHistoryVO();
					updateVo.setFactoryCd(tempVo.getFactoryCd());
					updateVo.setLogSeq(tempVo.getLogSeq());
					updateVo.setResultCd(rtnString);
					
					if( "AP1002".equals(rtnString) ) {
						updateVo.setInterfaceYn("Y");
					} else {
						updateVo.setInterfaceYn("N");
					}
					
					rtn = userHistoryService.update(updateVo);
					if( rtn.getRc() == GlvConst.RC_ERROR ) {
						log.debug(rtn.getMsg());
					}
				}
			}
			
		} catch (Exception e) {
			log.debug("####################		callLogApiTodayMinute Exception		####################");
			log.debug(e.getMessage());
		}
		
//		log.debug("Scheduler callLogApiTodayMinute end");
	}
	
	public String getParamString(UserHistoryVO paramVo) throws UnsupportedEncodingException {
		String rtnString = "";
		rtnString += "crtfcKey=" + URLEncoder.encode(proPertyService.getLogApiKey(), "UTF-8");
		rtnString += "&logDt=" + URLEncoder.encode(paramVo.getWriteDtStr(), "UTF-8");
		rtnString += "&useSe=" + URLEncoder.encode(paramVo.getLogTypeNm(), "UTF-8");
		rtnString += "&sysUser=" + URLEncoder.encode(paramVo.getLoginId(), "UTF-8");
		rtnString += "&conectIp=" + URLEncoder.encode(paramVo.getLoginIp(), "UTF-8");
		rtnString += "&dataUsgqty=" + URLEncoder.encode("0", "UTF-8");
		return rtnString;
	}
	
	public String sendREST(String sendUrl, String jsonValue) throws IllegalStateException {
        String inputLine = null;
        StringBuffer outResult = new StringBuffer();
        JSONParser parser = new JSONParser();
        JSONObject jsonObj;
		JSONObject result;
		String rtnString = "";
		String recptnRslt = "";
        
        try {
        	log.debug("REST API Start");
            URL url = new URL(sendUrl);
            HttpURLConnection conn = (HttpURLConnection)url.openConnection();
            conn.setDoOutput(true);
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setRequestProperty("Accept-Charset", "UTF-8");
            conn.setConnectTimeout(10000);
            conn.setReadTimeout(10000);
            
            OutputStream os = conn.getOutputStream();
            os.write(jsonValue.getBytes("UTF-8"));
            os.flush();
            
            // 리턴된 결과 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            while ((inputLine = in.readLine()) != null) {
                outResult.append(inputLine);
            }
            
            conn.disconnect();
            
            Object obj = parser.parse( outResult.toString() );
            jsonObj = (JSONObject) obj;
            result = (JSONObject) jsonObj.get("result");
            rtnString = (String) result.get("recptnRsltCd");
            recptnRslt = (String) result.get("recptnRslt");
            
            log.debug("REST API End");
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        return rtnString;
    }
}
