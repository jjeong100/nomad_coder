package org.rnt.material.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class MonthCloseInVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 6316172218901013312L;
	private String factoryCd;
	private String mendynSeq;
	private String magamYyyymm;
	private String workshopCd;
	private String magamYn;
	private String searchMagamYyyymm;
	private String searchWorkshopCd;
	private String writeId;
    private String updateId;
    
    public String getFactoryCd() {
        return factoryCd;
    }
    public void setFactoryCd(String factoryCd) {
        this.factoryCd = factoryCd;
    }
    public String getMendynSeq() {
        return mendynSeq;
    }
    public void setMendynSeq(String mendynSeq) {
        this.mendynSeq = mendynSeq;
    }
    public String getMagamYyyymm() {
        return magamYyyymm;
    }
    public void setMagamYyyymm(String magamYyyymm) {
        this.magamYyyymm = magamYyyymm;
    }
    public String getWorkshopCd() {
        return workshopCd;
    }
    public void setWorkshopCd(String workshopCd) {
        this.workshopCd = workshopCd;
    }
    public String getMagamYn() {
        return magamYn;
    }
    public void setMagamYn(String magamYn) {
        this.magamYn = magamYn;
    }
    public String getSearchMagamYyyymm() {
        return searchMagamYyyymm;
    }
    public void setSearchMagamYyyymm(String searchMagamYyyymm) {
        this.searchMagamYyyymm = searchMagamYyyymm;
    }
    public String getSearchWorkshopCd() {
        return searchWorkshopCd;
    }
    public void setSearchWorkshopCd(String searchWorkshopCd) {
        this.searchWorkshopCd = searchWorkshopCd;
    }
    public String getWriteId() {
        return writeId;
    }
    public void setWriteId(String writeId) {
        this.writeId = writeId;
    }
    public String getUpdateId() {
        return updateId;
    }
    public void setUpdateId(String updateId) {
        this.updateId = updateId;
    }
    
}
