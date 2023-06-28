package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MonthCloseOutVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 1316175218901013781L;
	private String workshopCd;
	private String workshopNm;
	private String magamYyyymm;
	private String magamYmd;
	private String magamYn;
	private String mendynSeq;
	
    public String getMendynSeq() {
        return mendynSeq;
    }
    public void setMendynSeq(String mendynSeq) {
        this.mendynSeq = mendynSeq;
    }
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
    public String getMagamYyyymm() {
        return magamYyyymm;
    }
    public void setMagamYyyymm(String magamYyyymm) {
        this.magamYyyymm = magamYyyymm;
    }
    public String getMagamYmd() {
        return magamYmd;
    }
    public void setMagamYmd(String magamYmd) {
        this.magamYmd = magamYmd;
    }
    public String getMagamYn() {
        return magamYn;
    }
    public void setMagamYn(String magamYn) {
        this.magamYn = magamYn;
    }
    
}
