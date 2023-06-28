package org.rnt.com.entity.vo;

import java.io.Serializable;
import java.util.Date;

import org.rnt.com.vo.SearchDefaultVO;

public class CodeVO extends SearchDefaultVO implements Serializable {
    static final long serialVersionUID = 2113001257186777699L;
    private String factoryCd;
    private String bcode;
    private String scode;
    private String codeNm;
    private Integer sortOrder;
    private String bigo;
    private String useYn;
    private Date writeDt;
    private String writeId;
    private Date updateDt;
    private String updateId;

    private String searchCodeNm;
    private String searchComCodeNm;


    public String getSearchComCodeNm() {
		return searchComCodeNm;
	}
	public void setSearchComCodeNm(String searchComCodeNm) {
		this.searchComCodeNm = searchComCodeNm;
	}
	public String getSearchCodeNm() {
        return searchCodeNm;
    }
    public void setSearchCodeNm(String searchCodeNm) {
        this.searchCodeNm = searchCodeNm;
    }
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getBcode() {
        return bcode;
    }
    public void setBcode(String bcode) {
        this.bcode = bcode;
    }
    public String getScode() {
        return scode;
    }
    public void setScode(String scode) {
        this.scode = scode;
    }
    public String getCodeNm() {
        return codeNm;
    }
    public void setCodeNm(String codeNm) {
        this.codeNm = codeNm;
    }
    public Integer getSortOrder() {
        return sortOrder;
    }
    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }
    public String getBigo() {
        return bigo;
    }
    public void setBigo(String bigo) {
        this.bigo = bigo;
    }
    public String getUseYn() {
        return useYn;
    }
    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }
    public Date getWriteDt() {
        return writeDt;
    }
    public void setWriteDt(Date writeDt) {
        this.writeDt = writeDt;
    }
    public String getWriteId() {
        return writeId;
    }
    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }
    public Date getUpdateDt() {
        return updateDt;
    }
    public void setUpdateDt(Date updateDt) {
        this.updateDt = updateDt;
    }
    public String getUpdateId() {
        return updateId;
    }
    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }

}
