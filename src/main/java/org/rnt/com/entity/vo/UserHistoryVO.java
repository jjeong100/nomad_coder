package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class UserHistoryVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6193159464570146813L;
	private String factoryCd;
	private String logSeq;
	private String loginId;
	private String loginNm;
	private String loginIp;
	private String logTypeCd;
	private String logTypeNm;
	private String pageUrl;
	private java.util.Date writeDt;
	private String writeDtStr;
	private String interfaceYn;
	private String resultCd;
	
	private String searchLogTypeCd;
	private String searchLoginId;
	private String searchNotInterfaceYn;
	
	
	public String getSearchLogTypeCd() {
        return searchLogTypeCd;
    }
    public void setSearchLogTypeCd(String searchLogTypeCd) {
        this.searchLogTypeCd = searchLogTypeCd;
    }
    public String getSearchLoginId() {
        return searchLoginId;
    }
    public void setSearchLoginId(String searchLoginId) {
        this.searchLoginId = searchLoginId;
    }
    public String getWriteDtStr() {
        return writeDtStr;
    }
    public void setWriteDtStr(String writeDtStr) {
        this.writeDtStr = writeDtStr;
    }
    public String getLoginNm() {
        return loginNm;
    }
    public void setLoginNm(String loginNm) {
        this.loginNm = loginNm;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getLogSeq() {
		return logSeq;
	}
	public void setLogSeq(String logSeq) {
		this.logSeq = logSeq;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginIp() {
		return loginIp;
	}
	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}
	public String getLogTypeCd() {
		return logTypeCd;
	}
	public void setLogTypeCd(String logTypeCd) {
		this.logTypeCd = logTypeCd;
	}
	public String getLogTypeNm() {
		return logTypeNm;
	}
	public void setLogTypeNm(String logTypeNm) {
		this.logTypeNm = logTypeNm;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public java.util.Date getWriteDt() {
		return writeDt;
	}
	public void setWriteDt(java.util.Date writeDt) {
		this.writeDt = writeDt;
	}
	public String getInterfaceYn() {
		return interfaceYn;
	}
	public void setInterfaceYn(String interfaceYn) {
		this.interfaceYn = interfaceYn;
	}
	public String getSearchNotInterfaceYn() {
		return searchNotInterfaceYn;
	}
	public void setSearchNotInterfaceYn(String searchNotInterfaceYn) {
		this.searchNotInterfaceYn = searchNotInterfaceYn;
	}
	public String getResultCd() {
		return resultCd;
	}
	public void setResultCd(String resultCd) {
		this.resultCd = resultCd;
	}
}
