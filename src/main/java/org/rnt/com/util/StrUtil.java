package org.rnt.com.util;

import java.io.File;
import java.util.LinkedList;
import java.util.List;
import java.util.Stack;
import java.util.StringTokenizer;

/**
 * @Class Name  : StringUtil.java
 * @Description : 스트링 처리를 위한 유팅 클래스
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2010.07.29           최초생성
 *
 * @author 임진영
 * @since 2010.07.29
 * @version 1.0
 * @see
 *
 *
 */

/**
 * 문자열을 조작하기 위한 유틸리티 메소드들을 포함한다.
 * @see rms.framework.message.MessageFormatter
 */
public class StrUtil {
	
	
	 public static final String C_DRIVER = "C:";

    /**  DASH 문자  */
    public static final String DASH = "-";

    /**  BLANK  문자 */
    public static final String BLANK = "";

    /**  NULL 문자 */
    public static final String NULL = "null";

    public static boolean isDigit(char character) {
      return Character.isDigit(character);
    }
    
    public static boolean isEnglishOnly(String src_str) {
    	
    	if (isNullOrEmpty(src_str)) return false;
    	
    	for (int i=0; i<src_str.length(); i++) {
    		char c = src_str.charAt(i);
    		if (!(( 0x61 <= c && c <= 0x7A) || (0x41 <= c && c <= 0x5A))) {
    			return false;
    		}
    	}
    	
    	return true;
    }
    
    public static boolean isEnglishOrDigitOnly(String src_str) {
    	
    	if (isNullOrEmpty(src_str)) return false;
    	
    	for (int i=0; i<src_str.length(); i++) {
    		char c = src_str.charAt(i);
    		if (!(( 0x61 <= c && c <= 0x7A) || (0x41 <= c && c <= 0x5A))) {
    			if (!isDigit(c)) {
                    return false;
                }
    		}
    	}
    	
    	return true;
    }


    public static boolean isNullOrEmpty(String string) {
    boolean boolRtn = false;
        if (string == null) {
            boolRtn = true;
        }else{
            if ((string.trim().equals(NULL)) ||
                (string.trim().equals(BLANK))) {
            boolRtn = true;
            }else{
            boolRtn = false;
            }
        }

        return boolRtn;
    }

    public static boolean isNumber(String s) {
    boolean boolRtn = false;
        if (isNullOrEmpty(s)) {
            boolRtn = true;
        }else{

            char[] characters = s.toCharArray();

            for (int i = 0; i < characters.length; i++) {
                if (!isDigit(characters[i])) {
                    return false;
                }
            }
            boolRtn = true;
        }

        return boolRtn;
    }

    public static String replace(String inString, String oldPattern, String newPattern) {
    String strRtn = null;
        StringBuffer sbuf = null;
        if (inString == null) {
            strRtn = null;
        }else if (oldPattern == null || newPattern == null) {
            strRtn = inString;
        }else{

            sbuf = new StringBuffer();
            int pos = 0;
            int index = inString.indexOf(oldPattern);
            int patLen = oldPattern.length();
            while (index >= 0) {
                sbuf.append(inString.substring(pos, index));
                sbuf.append(newPattern);
                pos = index + patLen;
                index = inString.indexOf(oldPattern, pos);
            }
            sbuf.append(inString.substring(pos));
            strRtn = sbuf.toString();
        }
        return strRtn;
    }

    public static String[] delimitedListToStringArray(String string, String delimiter) {
    String strRtn[] = null;
        List list = null;
        if (string == null) {
            strRtn = new String[0];
        }else if (delimiter == null) {
            strRtn = new String[] { string };
        }else{

            list = new LinkedList();
            int pos = 0;
            int delpos = 0;
            while((delpos = string.indexOf(delimiter,pos))!= -1) {
                list.add(string.substring(pos, delpos));
                pos = delpos + delimiter.length();
            }

            if (pos <= string.length()) {
                list.add(string.substring(pos));
            }
            strRtn = (String [])list.toArray(new String [0]);
        }
        return strRtn;
    }

    public static String nullToEmpty(String string) {
    String strRtn = null;
        if (string == null) {
            strRtn = BLANK;
        }else{
            strRtn = string;
        }
        return strRtn;
    }

	public static String isNullToString(Object object) {
		String string = "";

		if (object != null) {
			string = object.toString().trim();
		}

		return string;
	}

    public static String isNullToString(Object object, String string) {
        String resultVal = "";
        if (object != null) {
            resultVal =  object.toString().trim();
        }else{
            resultVal = string;
        }
        return  resultVal;
    }
    
    public static boolean isNull(String str) {
        if (str == null) return true;
        if ("".equals(str)) return true;        
        return false;
    }
    
    
    public static String getLastAfterStr(String srcStr, String tarStr) {        
        if (srcStr == null) return srcStr;
        if (tarStr == null) return srcStr;
        int pos = srcStr.lastIndexOf(tarStr);
        if (pos != -1) return srcStr.substring(pos+tarStr.length());
        else return null;
    }
    
    public static String getFirstBeforeStr(String srcStr, String tarStr) {        
        if (srcStr == null) return srcStr;
        if (tarStr == null) return srcStr;
        int pos = srcStr.indexOf(tarStr);
        if (pos != -1) return srcStr.substring(0,pos);
        else return null;
    }
    
    public static String getFirstAfterStr(String srcStr, String tarStr) {        
        if (srcStr == null) return srcStr;
        if (tarStr == null) return srcStr;
        int pos = srcStr.indexOf(tarStr);
        if (pos != -1) return srcStr.substring(pos+tarStr.length());
        else return null;
    }
    
    public static String parseRule(String src_str) {
    	if (src_str == null) return null;
    	
    	Stack<Integer> stack = new Stack<Integer>();
    	char ch;
    	int start_pos = 0;
    	int end_pos = 0;
    	boolean is_first = false;
    	for(int i=0; i<src_str.length(); i++) {
    		ch = src_str.charAt(i);
    		if(ch == '(') {
    			stack.push(i);
    			if (!is_first) {
    				is_first = true;
    				start_pos = i;
    			}
    		} else if(ch == ')') {
    			stack.pop();
    			if(stack.empty()) {
    				end_pos = i;
    				break;
    			}
    		}
    	}
    	
    	if (end_pos <= 0) {
    		return src_str;
    	} else {
    		return src_str.substring(start_pos+1, end_pos);
    	}
    }
    
    public static String parseAfterRule(String src_str) {
    	if (src_str == null) return null;
    	
    	Stack<Integer> stack = new Stack<Integer>();
    	char ch;
    	int start_pos = 0;
    	int end_pos = 0;
    	boolean is_first = false;
    	for(int i=0; i<src_str.length(); i++) {
    		ch = src_str.charAt(i);
    		if(ch == '(') {
    			stack.push(i);
    			if (!is_first) {
    				is_first = true;
    				start_pos = i;
    			}
    		} else if(ch == ')') {
    			stack.pop();
    			if(stack.empty()) {
    				end_pos = i;
    				break;
    			}
    		}
    	}
    	
    	if (end_pos <= 0) {
    		return src_str;
    	} else {
    		return src_str.substring(end_pos);
    	}
    }
    
    
    public static String ltrim(String s) 
	{
		char[] val = s.toCharArray();		
		int st  = 0;
		int len = s.length();
		while (st < len && val[st] <= ' ') 
		{
			st++;
		}
		return s.substring(st, len);
	}
    
    
    public static String getMidStr(String srcStr, String startStr, String endStr) {        
        if (srcStr == null) return srcStr;
        if (startStr == null) return srcStr;
        if (endStr == null) return srcStr;
        
        int start_pos = srcStr.lastIndexOf(startStr);
        int end_pos = srcStr.lastIndexOf(endStr);
        
        if (start_pos !=1 && end_pos!=-1) {
            return srcStr.substring(start_pos+startStr.length(), end_pos);
        } else return srcStr;
    }
    
    public static String[] TokenToArrStr(String srcStr, String tokenStr) {
        int i = 0;
        StringTokenizer token;
        String[] returnStr;
        try {
            token = new StringTokenizer(srcStr, tokenStr);
            returnStr = new String[token.countTokens()];
            
            while (token.hasMoreTokens()) {
                returnStr[i] = token.nextToken();               
                i++;
            }
            return returnStr;
        } catch (Exception e) {
            return null;
        }       
    }
    
    
    public static String convLinuxToWindowPathStr(String str) {
    	String rtnStr = "";
        if (str == null) return null;
        if ("".equals(str)) return rtnStr;
        
        rtnStr = StrUtil.C_DRIVER + str.replace("/", File.separator);
        
        return rtnStr;
    }
    
    
}