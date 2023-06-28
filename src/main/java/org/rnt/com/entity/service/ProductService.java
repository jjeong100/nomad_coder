package org.rnt.com.entity.service;

import org.rnt.com.entity.vo.ProductVO;
import org.rnt.com.vo.RtnVO;

public interface ProductService {
	public RtnVO insert(ProductVO param);
	public RtnVO select(ProductVO param);
	public RtnVO update(ProductVO param);
	public RtnVO delete(ProductVO param);
	public RtnVO searchList(ProductVO param);
	public RtnVO searchListTotCnt(ProductVO param);
}
