package com.spring.Uhdiya.board.qna;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDAO {
	@Autowired SqlSession sqlSession;

	public List<QnaDTO> product_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.qna.product_qna",pageMap);
	}

	public int total_product_qna(String product_code) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.qna.total_product_qna",product_code);
	}

	public int addQna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		int qna_id = new_qna_number()+1;
		qnaMap.put("qna_id", qna_id);
		List<QnaFileDTO> imageList = (List<QnaFileDTO>) qnaMap.get("imageList");
		if(imageList != null) {
			insert_qna_file(qnaMap);
		}
		sqlSession.insert("mapper.qna.insert_qna",qnaMap);
		return qna_id;
	}

	private void insert_qna_file(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		List<QnaFileDTO> imageList = (List<QnaFileDTO>) qnaMap.get("imageList");
		Integer qna_id = (Integer) qnaMap.get("qna_id");
		int qna_fileId = new_qna_file_number();
		
		for(QnaFileDTO dto : imageList) {
			dto.setQna_fileId(++qna_fileId);
			dto.setQna_id(qna_id);
		}
		sqlSession.insert("mapper.qna.insert_qna_file",imageList);
	}

	private int new_qna_file_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.qna.new_qna_file_number");
	}

	private int new_qna_number() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.qna.new_qna_number");
	}

	public void update_qna(Map<String, Object> qnaMap) {
		// TODO Auto-generated method stub
		Integer qna_id = Integer.parseInt((String) qnaMap.get("qna_id"));
		sqlSession.update("mapper.qna.update_qna",qnaMap);
		if(qnaMap.get("imageList") != null) {
			sqlSession.delete("mapper.qna.delete_qna_file",qna_id);
			insert_qna_file(qnaMap);
		}
	}

	public void delete_qna(int qna_id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.qna.delete_qna",qna_id);
		sqlSession.delete("mapper.qna.delete_qna_file",qna_id);
	}

	public List<QnaDTO> qna_list(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.qna.all_qna",pageMap);
	}

	public int total_qna() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.qna.total_qna");
	}

	public int total_my_qna(String qna_writeId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.qna.total_my_qna",qna_writeId);
	}

	public List<QnaDTO> my_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.qna.my_qna",pageMap);
	}

	public Map<String, Object> one_qna(int qna_id) {
		// TODO Auto-generated method stub
		QnaDTO qnaDTO = sqlSession.selectOne("mapper.qna.one_qna", qna_id);
		List<QnaFileDTO> qnaFileList = sqlSession.selectList("mapper.qna.one_qna_file", qna_id);
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		qnaMap.put("qnaDTO", qnaDTO);
		qnaMap.put("qnaFileList", qnaFileList);
		return qnaMap;
	}

	public int update_parentId(int qna_id) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.qna.update_parentId",qna_id);
	}

	public int insert_reply(QnaDTO qnaDTO) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.qna.insert_reply",qnaDTO);
	}

	public List<QnaDTO> my_qna_reply(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.qna.my_qna_reply",pageMap);
	}

	public Map<String, Object> all_qna(Map<String, Object> pageMap) {
		// TODO Auto-generated method stub
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		List<QnaDTO> qna_list = sqlSession.selectList("mapper.qna.all_all_qna",pageMap);
		int total_qna = total_qna();
		qnaMap.put("total_qna", total_qna);
		qnaMap.put("qna_list", qna_list);
		return qnaMap;
	}
}