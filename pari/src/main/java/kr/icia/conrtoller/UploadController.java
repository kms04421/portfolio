package kr.icia.conrtoller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
// 이미지 처리를 위해서는 awt 패키지 사용할 수 있어요.
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.icia.domain.AttachVO;
import kr.icia.domain.GoodsAttachVO;
import kr.icia.service.GoodsService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class UploadController {
	
	private GoodsService goodsservice;
	
	String uploadFolder = "c:\\upload";
	
	// fileUploadAjax
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/fileUploadAjax", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<GoodsAttachVO>> FileUpload(MultipartFile[] uploadFile) {
//		log.info("UploadAction......" + uploadFile);

		List<GoodsAttachVO> list = new ArrayList<>();
		// 여러개 파일 저장을 위한 객체 배열타입 선언

		// 저장 경로
		String uploadFolder = "c:\\upload";

		// 파일 이름
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);

		File uploadPath = new File(uploadFolder, datePath);
		// 파일이 없다면 파일 생성
		if (uploadPath.exists() == false) {
			// uploadPath.mkdir();
			uploadPath.mkdirs();

		}

		log.info("uploadPath: " + uploadPath);

		// 향상된 for문을 이용한 여러 파일 정보 출력
		for (MultipartFile multipartFile : uploadFile) {
			GoodsAttachVO vo = new GoodsAttachVO();
			log.info("for (MultipartFile......" + uploadFile);
			// 파일 원래이름
			String uploadFileName = multipartFile.getOriginalFilename();

			// 파일 이름에 uuid적용 (이름 중복 방지)
			String uuid = UUID.randomUUID().toString();
			vo.setUuId(uuid);
			uploadFileName = uuid + "_" + uploadFileName;

			// 원래 파일과 썸네일의 type을 일치시키기 위한 변수 생성
			String type = multipartFile.getContentType();
			log.info("오리지날 타입 : " + type);
			type = type.substring(type.lastIndexOf("/") + 1);
			log.info("type:" + type);
			File saveFile = new File(uploadPath, uploadFileName);

			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			try {
				log.info("세이브 파일 : " + saveFile);
				multipartFile.transferTo(saveFile);

				log.info("vo:" + vo);
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				BufferedImage bfo_img = ImageIO.read(saveFile);
				BufferedImage bto_img = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
				log.info("thumbnailFile:" + thumbnailFile);
				Graphics2D graphic = bto_img.createGraphics();
				graphic.drawImage(bfo_img, 0, 0, 200, 200, null);

				ImageIO.write(bto_img, type, thumbnailFile);
				list.add(vo);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return new ResponseEntity<>(list, HttpStatus.OK);

	}

	// 이미지 불러오기
	@GetMapping("/detail")
	public ResponseEntity<byte[]> getImage(String fileName) {
		log.info("get image........" + fileName);
		File file = new File("c:/upload/" + fileName);
		log.info("file:" + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));

			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile: " + fileName);
		File file;
		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));	
			file.delete();
			// 파일 삭제.
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
		// return null;
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/ckUpload", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<GoodsAttachVO>> ckUpload(MultipartFile[] uploadFile) {


		List<GoodsAttachVO> list = new ArrayList<>();
	

		// 저장 경로
		String uploadFolder = "c:\\upload";

		// 파일 이름
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		String datePath = str.replace("-", File.separator);

		File uploadPath = new File(uploadFolder, datePath);
		// 파일이 없다면 파일 생성
		if (uploadPath.exists() == false) {
			// uploadPath.mkdir();
			uploadPath.mkdirs();

		}

		log.info("uploadPath: " + uploadPath);

		// 향상된 for문을 이용한 여러 파일 정보 출력
		for (MultipartFile multipartFile : uploadFile) {
			GoodsAttachVO vo = new GoodsAttachVO();
			log.info("for (MultipartFile......" + uploadFile);
			// 파일 원래이름
			String uploadFileName = multipartFile.getOriginalFilename();

			// 파일 이름에 uuid적용 (이름 중복 방지)
			String uuid = UUID.randomUUID().toString();
			vo.setUuId(uuid);
			uploadFileName = uuid + "_" + uploadFileName;

			// 원래 파일과 썸네일의 type을 일치시키기 위한 변수 생성
			String type = multipartFile.getContentType();
			log.info("오리지날 타입 : " + type);
			type = type.substring(type.lastIndexOf("/") + 1);
			log.info("type:" + type);
			File saveFile = new File(uploadPath, uploadFileName);

			vo.setFileName(uploadFileName);
			vo.setUploadPath(datePath);
			try {
				log.info("세이브 파일 : " + saveFile);
				multipartFile.transferTo(saveFile);

				log.info("vo:" + vo);
				File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				BufferedImage bfo_img = ImageIO.read(saveFile);
				BufferedImage bto_img = new BufferedImage(200, 200, BufferedImage.TYPE_3BYTE_BGR);
				log.info("thumbnailFile:" + thumbnailFile);
				Graphics2D graphic = bto_img.createGraphics();
				graphic.drawImage(bfo_img, 0, 0, 200, 200, null);

				ImageIO.write(bto_img, type, thumbnailFile);
				list.add(vo);

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return new ResponseEntity<>(list, HttpStatus.OK);

	}

	
	


}
