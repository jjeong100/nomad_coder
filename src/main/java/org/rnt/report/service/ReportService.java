package org.rnt.report.service;

import org.rnt.com.entity.vo.PlcVO;
import org.rnt.com.vo.RtnVO;
import org.rnt.report.vo.ReportDtlVO;
import org.rnt.report.vo.ReportEduVO;
import org.rnt.report.vo.ReportVO;

public interface ReportService {
	
	public RtnVO select(ReportVO param);
	public RtnVO selectDtlList(ReportVO param);
	
	public RtnVO insert(ReportVO param);
	public RtnVO update(ReportVO param);
	public RtnVO delete(ReportVO param);
	
	public RtnVO insertDtl(ReportDtlVO param);
	public RtnVO updateDtl(ReportDtlVO param);
	public RtnVO deleteDtl(ReportVO param);
	
	public RtnVO selectEdu(ReportEduVO param);
	public RtnVO insertEdu(ReportEduVO param);
	public RtnVO updateEdu(ReportEduVO param);
	public RtnVO deleteEdu(ReportEduVO param);
	
	public PlcVO selectPlc(String plcCd);
}
