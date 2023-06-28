package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class SubulOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316175218901013781L;
	private String workshopCd;
	private String workshopNm;
	private String sbDt;
	private String matCd;
	private String matNm;
	private String gubun;
	private String lotid;
	private String matCnt;
	private String matUnitVal;
	private String matUnitNm;
	
    public String getWorkshopCd() {
        return workshopCd;
    }
    public void setWorkshopCd(String workshopCd) {
        this.workshopCd = workshopCd;
    }
    public String getWorkshopNm() {
        return workshopNm;
    }
    public void setWorkshopNm(String workshopNm) {
        this.workshopNm = workshopNm;
    }
    public String getSbDt() {
        return sbDt;
    }
    public void setSbDt(String sbDt) {
        this.sbDt = sbDt;
    }
    public String getMatCd() {
        return matCd;
    }
    public void setMatCd(String matCd) {
        this.matCd = matCd;
    }
    public String getMatNm() {
        return matNm;
    }
    public void setMatNm(String matNm) {
        this.matNm = matNm;
    }
    public String getGubun() {
        return gubun;
    }
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }
    public String getLotid() {
        return lotid;
    }
    public void setLotid(String lotid) {
        this.lotid = lotid;
    }
    public String getMatCnt() {
        return matCnt;
    }
    public void setMatCnt(String matCnt) {
        this.matCnt = matCnt;
    }
	public String getMatUnitVal() {
		return matUnitVal;
	}
	public void setMatUnitVal(String matUnitVal) {
		this.matUnitVal = matUnitVal;
	}
	public String getMatUnitNm() {
		return matUnitNm;
	}
	public void setMatUnitNm(String matUnitNm) {
		this.matUnitNm = matUnitNm;
	}
    
}
