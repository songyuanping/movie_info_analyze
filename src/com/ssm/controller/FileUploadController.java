package com.ssm.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/8 0008
 * @version: 1.0
 */
@Controller
public class FileUploadController {
    @RequestMapping("/toUpload")
    public String toUpload() {
        return "fileUpload";
    }

    @RequestMapping("/fileUpload")
    public String handleFormUpload(@RequestParam("name") String name, @RequestParam("UploadFile") MultipartFile file, HttpServletRequest request) {
        if (!file.isEmpty() && file.getSize() > 0) {
            String uploadPath = request.getServletContext().getRealPath("upload");
            File uploadFile = new File(uploadPath);
            if (!uploadFile.exists()) {
                uploadFile.mkdirs();
            }
            String fileName = file.getOriginalFilename();
            String reFileName = name + UUID.randomUUID() + fileName;
            System.out.println("reFileName: " + reFileName);
            File newFile = new File(uploadPath + File.separator + reFileName);
            try {
                file.transferTo(newFile);
            } catch (IllegalStateException | IOException e) {
                e.printStackTrace();
            }
            return "success";
        }
        return "error";
    }
}
