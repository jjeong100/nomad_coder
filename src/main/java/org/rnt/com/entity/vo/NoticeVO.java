package org.rnt.com.entity.vo;
import java.io.Serializable;
import org.rnt.com.vo.SearchDefaultVO;

public class NoticeVO extends SearchDefaultVO implements Serializable {
	static final long serialVersionUID = 7080925805826886085L;
	private String factoryCd;
	private String noticeSeq;
	private String title;
	private String content;
	private String useYn;
	private java.util.Date writeDt;
	private String writeId;
	private java.util.Date updateDt;
	private String updateId;
	
	private String updateNm;
	private String updateDtStr;
	private String searchTitle;
	public String getUpdateNm() {
        return updateNm;
    }
    public void setUpdateNm(String updateNm) {
        this.updateNm = updateNm;
    }
    public String getUpdateDtStr() {
        return updateDtStr;
    }
    public void setUpdateDtStr(String updateDtStr) {
        this.updateDtStr = updateDtStr;
    }
    public String getSearchTitle() {
        return searchTitle;
    }
    public void setSearchTitle(String searchTitle) {
        this.searchTitle = searchTitle;
    }
    public String getFactoryCd() {
		return factoryCd;
	}
	public void setFactoryCd(String factoryCd) {
		this.factoryCd = factoryCd;
	}
	public String getNoticeSeq() {
		return noticeSeq;
	}
	public void setNoticeSeq(String noticeSeq) {
		this.noticeSeq = noticeSeq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
}
