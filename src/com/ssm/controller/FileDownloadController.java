package com.ssm.controller;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * @description:
 * @author: song yuanping
 * @createDate: 2020/3/8 0008
 * @version: 1.0
 */

@Controller
public class FileDownloadController {
    // 转到下载页面
    @RequestMapping("/toDownload")
    public String toDownload() {
        return "download";
    }

    @RequestMapping("/download")
    public ResponseEntity<byte[]> download(HttpServletRequest request, String filename) throws Exception  {

        request.setCharacterEncoding("UTF-8");
        //解决下载过程中不同浏览器中文编码问题
        String path = request.getServletContext().getRealPath("/download/");
        File file = new File(path + filename);
        filename = this.getFilename(request, filename);
        HttpHeaders header = new HttpHeaders();
        // 通知浏览器以下载的方式打开文件
        header.setContentDispositionFormData("attachment", filename);
        // 以流的形式下载数据
        header.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        //使用Sring MVC框架的ResponseEntity对象封装返回下载数据
        return new ResponseEntity<>(FileUtils.readFileToByteArray(file), header, HttpStatus.OK);
    }

    public String getFilename(HttpServletRequest request, String filename) throws Exception {
        request.setCharacterEncoding("UTF-8");
        // IE不同版本User-Agent中出现的关键词
        String[] IEBrowserKeyWords = { "MSIE", "Trident", "Edge" };
        // 获取请求头代理信息
        String userAgent = request.getHeader("User-Agent");
        //IE内核浏览器，统一为UTF-8编码显示
        for (String keyWord : IEBrowserKeyWords) {
            if (userAgent.contains(keyWord)) {
                return URLEncoder.encode(filename, "UTF-8");
            }
        }
        //火狐等其它浏览器统一为ISO-8859-1编码显示
        return new String(filename.getBytes(StandardCharsets.UTF_8), StandardCharsets.ISO_8859_1);
    }
}
