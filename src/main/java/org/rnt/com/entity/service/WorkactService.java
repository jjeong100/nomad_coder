package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.WorkactInfoVO;
import org.rnt.com.entity.vo.WorkactRsltVO;
import org.rnt.com.vo.RtnVO;

public interface WorkactService {
	public RtnVO insertInfo(WorkactInfoVO param);
	public RtnVO selectInfo(WorkactInfoVO param);
	public RtnVO updateInfo(WorkactInfoVO param);
	public RtnVO deleteInfo(WorkactInfoVO param);
	
	public RtnVO insertRslt(WorkactRsltVO param);
	public RtnVO selectRslt(WorkactRsltVO param);
	public RtnVO selectRsltList(WorkactRsltVO param);
	public RtnVO updateRslt(WorkactRsltVO param);
	public RtnVO deleteRslt(WorkactRsltVO param);
}
