package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.MaterialOutVO;
import org.rnt.com.vo.RtnVO;

public interface MaterialOutService {
	public RtnVO insert(MaterialOutVO param);
	public RtnVO select(MaterialOutVO param);
	public RtnVO update(MaterialOutVO param);
	public RtnVO delete(MaterialOutVO param);
	public RtnVO searchList(MaterialOutVO param);
	public RtnVO searchListTotCnt(MaterialOutVO param);
	public int checkMaterialOut(MaterialOutVO param);
	public RtnVO checkMatOutEndYn(MaterialOutVO param);
}
