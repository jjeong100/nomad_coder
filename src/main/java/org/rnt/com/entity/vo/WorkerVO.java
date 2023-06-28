package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class WorkerVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 7485597113801393162L;
	private String factoryCd;
	private String loginId;
	private String loginName;
	private String sabunId;
	private String shortId;
	private String passCd;
	private String departCd;
	private String departNm;
	private String jikCd;
	private String jikNm;
	private String jikchaekCd;
	private String jikchaekNm;
	private String email;
	private String mobileNo;
	private String workCd;
	private String workNm;
	private String levelCd;
	private String levelNm;
	private String ipdaDt;
	private java.util.Date lastConDt;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	// add
	private String searchSabunId;
	private String searchLoginName;
	
	private String mobileYn;
	
	public String getMobileYn() {
		return mobileYn;
	}

	public void setMobileYn(String mobileYn) {
		this.mobileYn = mobileYn;
	}
	/**
	 * 20201111 jeonghwan
	 * 사용자 페스워드 변경
	 * @return
	 */
	private String inPassWord;   //기존 페스워드 비교 입력
	private String newPassWord;  //신규 페스워드
	//private String confPassWord; //신규 페스워드 확인 화면처리
	
	public String getInPassWord() {
		return inPassWord;
	}
	
	public void setInPassWord(String inPassWord) {
		this.inPassWord = inPassWord;
	}
	
	public String getNewPassWord() {
		return newPassWord;
	}
	
	public void setNewPassWord(String newPassWord) {
		this.newPassWord = newPassWord;
	}
	
	public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getSabunId() {
		return sabunId;
	}
	public void setSabunId(String sabunId) {
		this.sabunId = sabunId;
	}
	public String getShortId() {
		return shortId;
	}
	public void setShortId(String shortId) {
		this.shortId = shortId;
	}
	public String getPassCd() {
		return passCd;
	}
	public void setPassCd(String passCd) {
		this.passCd = passCd;
	}
	public String getDepartCd() {
		return departCd;
	}
	public void setDepartCd(String departCd) {
		this.departCd = departCd;
	}
	public String getDepartNm() {
		return departNm;
	}
	public void setDepartNm(String departNm) {
		this.departNm = departNm;
	}
	public String getJikCd() {
		return jikCd;
	}
	public void setJikCd(String jikCd) {
		this.jikCd = jikCd;
	}
	public String getJikNm() {
		return jikNm;
	}
	public void setJikNm(String jikNm) {
		this.jikNm = jikNm;
	}
	public String getJikchaekCd() {
		return jikchaekCd;
	}
	public void setJikchaekCd(String jikchaekCd) {
		this.jikchaekCd = jikchaekCd;
	}
	public String getJikchaekNm() {
		return jikchaekNm;
	}
	public void setJikchaekNm(String jikchaekNm) {
		this.jikchaekNm = jikchaekNm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getWorkCd() {
		return workCd;
	}
	public void setWorkCd(String workCd) {
		this.workCd = workCd;
	}
	public String getWorkNm() {
		return workNm;
	}
	public void setWorkNm(String workNm) {
		this.workNm = workNm;
	}
	public String getLevelCd() {
		return levelCd;
	}
	public void setLevelCd(String levelCd) {
		this.levelCd = levelCd;
	}
	public String getLevelNm() {
		return levelNm;
	}
	public void setLevelNm(String levelNm) {
		this.levelNm = levelNm;
	}
	public String getIpdaDt() {
		return ipdaDt;
	}
	public void setIpdaDt(String ipdaDt) {
		this.ipdaDt = ipdaDt;
	}
	public java.util.Date getLastConDt() {
		return lastConDt;
	}
	public void setLastConDt(java.util.Date lastConDt) {
		this.lastConDt = lastConDt;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public java.util.Date getWriteDt() {
		return writeDt;
	}
	public void setWriteDt(java.util.Date writeDt) {
		this.writeDt = writeDt;
	}
	public String getWriteId() {
		return writeId;
	}
	public void setWriteId(String writeId) {
		this.writeId = writeId;
	}
	public java.util.Date getUpdateDt() {
		return updateDt;
	}
	public void setUpdateDt(java.util.Date updateDt) {
		this.updateDt = updateDt;
	}
	public String getUpdateId() {
		return updateId;
	}
	public void setUpdateId(String updateId) {
		this.updateId = updateId;
	}
	public String getSearchSabunId() {
		return searchSabunId;
	}
	public void setSearchSabunId(String searchSabunId) {
		this.searchSabunId = searchSabunId;
	}
	public String getSearchLoginName() {
		return searchLoginName;
	}
	public void setSearchLoginName(String searchLoginName) {
		this.searchLoginName = searchLoginName;
	}
    
}
