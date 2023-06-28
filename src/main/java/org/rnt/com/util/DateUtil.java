package org.rnt.com.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * @Class Name  : DateUtil.java
 * @Description :  Date 포맷 유틸 클래스
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2010.07.29           최초생성
 *
 * @author 박재현
 * @since 2010.07.29
 * @version 1.0
 * @see
 *
 */
public class DateUtil {

    /*
     * 유틸리티 클래스이므로 생성자를 private로 설정한다.
     */
    private DateUtil() {
    }

    /**
     * 입력 문자열이 날짜 타입인지 확인한다.
     *
     * @param date      입력 문자열
     * @param pattern   날짜 패턴
     * @return true - 입력 문자열이 날짜 타입인 경우; false - 입력 문자열이 날짜 타입이 아닌 경우
     */
    public static boolean isDate(String date, String pattern) {
        if (pattern == null) {
            throw new NullPointerException("문자열 포맷 형식인 format이 null입니다.");
        }

        if (date == null) {
            return true;
        }

        SimpleDateFormat formatter = new SimpleDateFormat(pattern);
        java.util.Date parsedDate = null;

        try {
            parsedDate = formatter.parse(date);
        } catch (java.text.ParseException ex) {
            return false;
        }

        if (!formatter.format(parsedDate).equals(date)) {
            return false;
        }

        return true;
    }

    /**
     * 현재 날짜를 "yyyyMMdd" 형식의 문자열로 포맷한다.
     *
     * @return "yyyyMMdd" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentDate() {
        return formatCurrent("yyyyMMdd");
    }

    /**
     * 현재 날짜를 "HHmmss" 형식의 문자열로 포맷한다.
     *
     * @return "HHmmss" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentTime() {
        return formatCurrent("HHmmss");
    }

    /**
     * 현재 날짜를 "yyyyMMddHHmmss" 형식의 문자열로 포맷한다.
     *
     * @return "yyyyMMddHHmmss" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentDateTime() {
        return formatCurrent("yyyyMMddHHmmss");
    }

    /**
     * 현재 날짜를 "yyyy-MM-dd" 형식의 문자열로 포맷한다.
     *
     * @return "yyyy-MM-dd" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentDateAsRegularFormat() {
        return formatCurrent("yyyy-MM-dd");
    }

    /**
     * 현재 날짜를 "HH:mm:ss" 형식의 문자열로 포맷한다.
     *
     * @return "HH:mm:ss" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentTimeAsRegularFormat() {
        return formatCurrent("HH:mm:ss");
    }

    /**
     * 현재 날짜를 "yyyy-MM-dd HH:mm:ss" 형식의 문자열로 포맷한다.
     *
     * @return "yyyy-MM-dd HH:mm:ss" 형식으로 포맷된 현재 날짜
     */
    public static String formatCurrentDateTimeAsRegularFormat() {
        return formatCurrent("yyyy-MM-dd HH:mm:ss");
    }

    /**
    * 현재 일자를 생성하여 리턴한다.
    *
    * @param pattern 날짜 패턴
    * @return 현재날짜
    */
    public static String formatCurrent(String pattern) {
        return new SimpleDateFormat(pattern).format( currentDate() );
    }

    /**
     * "yyyyMMddHHmmss" 형식의 문자열을 "yyyyMMdd"로 포맷한다.
     *
     * @return "yyyyMMdd" 형식으로 포맷된 현재 날짜
     */
    public static String formatDate(String recvDate) {
        return format(recvDate, "yyyyMMdd");
    }

    /**
     * "yyyyMMddHHmmss" 형식의 문자열을 "HHmmss"로 포맷한다.
     *
     * @return "HHmmss" 형식으로 포맷된 현재 날짜
     */
    public static String formatTime(String recvDate) {
        return format(recvDate, "HHmmss");
    }

    /**
     * "yyyyMMddHHmmss" 형식의 문자열을 "yyyy-MM-dd"로 포맷한다.
     *
     * @return "yyyy-MM-dd" 형식으로 포맷된 현재 날짜
     */
    public static String formatDateAsRegularFormat(String recvDate) {
        return format(recvDate, "yyyy-MM-dd");
    }
    
    public static String formatDateAsSlashFormat(String recvDate) {
        return format2(recvDate, "yyyy/MM/dd");
    }
    
    public static String formatMonthAsSlashFormat(String recvDate) {
        return format3(recvDate, "yyyy/MM");
    }

    /**
     * "yyyyMMddHHmmss" 형식의 문자열을 "HH:mm:ss"로 포맷한다.
     *
     * @return "HH:mm:ss" 형식으로 포맷된 현재 날짜
     */
    public static String formatTimeAsRegularFormat(String recvDate) {
        return format(recvDate, "HH:mm:ss");
    }

    /**
     * "yyyyMMddHHmmss" 형식의 문자열을 명시된 패턴으로 포맷한다.
     *
     * @return "yyyyMMddHHmmss" 형식으로 포맷된 현재 날짜
     */
    public static String format(String recvDate, String formatPattern) {
        return format(recvDate, "yyyyMMddHHmmss", formatPattern);
    }
    
    public static String format2(String recvDate, String formatPattern) {
        return format(recvDate, "yyyyMMdd", formatPattern);
    }
    
    public static String format3(String recvDate, String formatPattern) {
        return format(recvDate, "yyyyMM", formatPattern);
    }

    /**
     * parsePattern 형식의 문자열을 formatPattern 형식의 문자열로 변환한다.
     *
     * @param recvDate 파싱할 문자열
     * @param formatPattern 변환할 결과 포맷
     * @return formatPattern에 맞게 변환된 날짜
     */
    public static String format(String recvDate, String parsePattern, String formatPattern) {
        Date date = parse(recvDate, parsePattern);
        return format(date, formatPattern);
    }

    /**
     * Date 형식의 날짜를 String형식으로 포맷하여 리턴한다.
     *
     * @param recvDate 포맷을 변경하고자 하는 날짜
     * @param formatPattern 변경하고자 하는 날짜 포맷
     * @return 날짜 String 타입
     */
    public static String format(Date recvDate, String formatPattern) {
        return new SimpleDateFormat(formatPattern).format(recvDate);
    }

    /**
     * String 형식의 날짜를 Date형식으로 파싱하여 리턴한다.

     * @param recvDate 포맷을 변경하고자 하는 날짜
     * @param formatPattern 변경하고자 하는 날짜 포맷
     * @return 날짜 Date 타입
     */
    public static Date parse(String recvDate, String parsePattern) {
        Date tempDate = new Date();
            try {
                tempDate =  new SimpleDateFormat(parsePattern).parse(recvDate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            return tempDate;
    }
    /**
     * 현재 일자에서 "yyyy" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getYear() {
        return formatCurrent("yyyy");
    }

    /**
     * * 현재 일자에서 "MM" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getMonth() {
        return formatCurrent("MM");
    }

    /**
     * * 현재 일자에서 "dd" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getDay() {
        return formatCurrent("dd");
    }

    /**
     * 현재 일자에서 "HH" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getHour() {
        return formatCurrent("HH");
    }

    /**
     * * 현재 일자에서 "mm" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getMinute() {
        return formatCurrent("mm");
    }

    /**
     * * 현재 일자에서 "ss" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static String getSecond() {
        return formatCurrent("ss");
    }

    /**
     * 현재 일자에서 "yyyy" 형식의 날짜 형식의 숫자를 요청한다.
     *
     * @return 날짜
     */
    public static int getYearAsNumber() {
        return formatAsNumber("yyyy");
    }

    /**
     * 현재 일자에서 "MM" 형식의 날짜 형식의 숫자를 요청한다.
     *
     * @return 날짜
     */
    public static int getMonthAsNumber() {
        return formatAsNumber("MM");
    }

    /**
     * 현재 일자에서 "dd" 형식의 날짜 형식의 숫자를 요청한다.
     *
     * @return 날짜
     */
    public static int getDayAsNumber() {
        return formatAsNumber("dd");
    }

    /**
     * 현재 일자에서 "HH" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static int getHourAsNumber() {
        return formatAsNumber("HH");
    }

    /**
     * * 현재 일자에서 "mm" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static int getMinuteAsNumber() {
        return formatAsNumber("mm");
    }

    /**
     * * 현재 일자에서 "ss" 형식의 날짜 형식의 문자열을 요청한다.
     *
     * @return 날짜
     */
    public static int getSecondAsNumber() {
        return formatAsNumber("ss");
    }


    /**
     * 입력 패턴 형식의 날짜 형식의 숫자를 요청한다.
     *
     * @return 날짜
     */
    private static int formatAsNumber(String pattern) {
        return Integer.parseInt(formatCurrent(pattern));
    }

    /**
     * 해당 년월의 처음 일자를 알아 요청한다
     *
     * @param year  년
     * @param month 월
     * @param day   일
     * @return 숫자
     */
    public static int getFirstMonth(int year, int month, int day) {
        Calendar temp_date = Calendar.getInstance();
        Calendar cal = Calendar.getInstance();
        temp_date = Calendar.getInstance();
        temp_date.set(Calendar.YEAR, year);
        temp_date.set(Calendar.MONTH, month - 1);
        temp_date.set(Calendar.DATE, 1);
        cal = temp_date;
        return cal.get(Calendar.DAY_OF_WEEK) - 1;
    }

    /**
     * 해당 년월의 전체 일수를 알아 요청한다.
     *
     * @param year  년
     * @param month 월
     * @return 숫자
     */
    public static int getDaysInMonth(int year, int month) {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.YEAR, year);
        calendar.set(Calendar.MONTH, month);
        calendar.set(Calendar.DATE, 0);
        return calendar.get(Calendar.DAY_OF_MONTH);
    }


    /**
     * "yyyyMMdd" 형식의 기준 일자에 기준 년도를 이동한 날짜를 Return 한다.
     *
     * @param DateString 기준 날짜
     * @param year       년
     * @return 날짜 문자열
     */
    public static String addDateYear(String dateString, int year) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

            calendar.setTime(formatter.parse(dateString));
            calendar.add(Calendar.YEAR, year);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateString;
        }
        return strRtn;
    }

    /**
     * "yyyyMMdd" 형식의 현재 입력한 날짜에 기준 월를 이동한 날짜를 Return 한다.
     *
     * @param dateString 기준 날짜
     * @param month      월
     * @return 날짜 문자열
     */
    public static String addDateMonth(String dateString, int month) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

            calendar.setTime(formatter.parse(dateString));
            calendar.add(Calendar.MONTH, month);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateString;
        }
        return strRtn;
    }

    /**
     * "yyyyMMdd" 형식의 현재 입력한 날짜에 기준 일자를 이동한 날짜를 Return 한다.
     *
     * @param dateString 기준 날짜
     * @param day        일
     * @return 날짜 문자열
     */
    public static String addDateDay(String dateString, int day) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");

            calendar.setTime(formatter.parse(dateString));
            calendar.add(Calendar.DATE, day);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 연을 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param hour           시간
     * @return 날짜 문자열
     */
    public static String addDateTimeYear(String dateTimeString, int year) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.YEAR, year);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 월을 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param minute         분
     * @return 날짜 문자열
     */
    public static String addDateTimeMonth(String dateTimeString, int month) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.MONTH, month);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 일을 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param second         초
     * @return 날짜 문자열
     */
    public static String addDateTimeDay(String dateTimeString, int day) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.DATE, day);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 시간을 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param hour           시간
     * @return 날짜 문자열
     */
    public static String addDateTimeHour(String dateTimeString, int hour) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.HOUR, hour);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 분를 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param minute         분
     * @return 날짜 문자열
     */
    public static String addDateTimeMinute(String dateTimeString, int minute) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.MINUTE, minute);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 현재 입력한 날짜(yyyyMMddhhmmss)형에 기준 초를 이동한 날짜를 Return 한다.
     *
     * @param DateTimeString 입력날짜
     * @param second         초
     * @return 날짜 문자열
     */
    public static String addDateTimeSecond(String dateTimeString, int second) {
    String strRtn = null;
        try {
            Calendar calendar = Calendar.getInstance();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

            calendar.setTime(formatter.parse(dateTimeString));
            calendar.add(Calendar.SECOND, second);

            strRtn = formatter.format(calendar.getTime());
        } catch (ParseException e) {
            strRtn = dateTimeString;
        }
        return strRtn;
    }

    /**
     * 해당 date에 대해 pattern의 형태의 String으로 리턴한다.
     * 예) getFormatedDate( new Date(), "yyyyMMdd" ) 값은 "20080502" 이다.
     *
     * @param DateTimeString 입력날짜
     * @param second         초
     * @return 날짜 문자열
     */
    public static String getFormatedDate(Date date, String pattern) {
        return new SimpleDateFormat(pattern).format( date );
    }
    
    public static String getFormatedDate(Date date, String pattern, Locale locale) {
        return new SimpleDateFormat(pattern,locale).format( date );
    }

    /**
     * 현재 시간을 밀리세컨드값으로 리턴한다.
     *
     * @return long 현재 시간 밀리세컨드값
     */
    public static long currentTimeMillis() {
        Calendar cal = Calendar.getInstance();
        cal.setTime( currentDate() );

        return cal.getTimeInMillis() ;
    }

    /**
     * 현재 일자를 생성하여 리턴한다.
     *
     * @return Date 현재 날짜
     */
    public static Date currentDate() {
        Date date = new Date();
        return date ;
    }
    
    public static String lastDay(String date, String pattern) {
    	String strRtn = null;
    	int year	= Integer.parseInt(getYear());
    	int month	= Integer.parseInt(getMonth());
    	int day		= Integer.parseInt(getDay());
    	
    	if( "".equals(date) ) {
    		date = formatCurrent("yyyyMMdd");
    	}
    	
		year	= Integer.parseInt(date.substring(0,  4));
		month	= Integer.parseInt(date.substring(4,  6));
		day		= Integer.parseInt(date.substring(6,  8));
    	
    	Calendar calendar = Calendar.getInstance();
    	SimpleDateFormat formatter = new SimpleDateFormat(pattern);
    	
    	calendar.set(year, month - 1, day);
    	calendar.set(year, month - 1, lastDay(date));
    	
    	strRtn = formatter.format(calendar.getTime());
    	
    	return strRtn;
    }
    
    public static int lastDay(String date) {
    	int year	= Integer.parseInt(getYear());
    	int month	= Integer.parseInt(getMonth());
    	int day		= Integer.parseInt(getDay());
    	
        if( !"".equals(date) ) {
			year	= Integer.parseInt(date.substring(0,  4));
			month	= Integer.parseInt(date.substring(4,  6));
			day		= Integer.parseInt(date.substring(6,  8));
		}
			
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day);
		day = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        return day;
    }
    
    
}