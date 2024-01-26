package com.ruoyi.common.oss;


import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.*;
import com.ruoyi.framework.config.ServerConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.InputStream;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * 使用s3协议进行封装的云存储工具类
 */
@Component
public class S3StoreClient {

    private OssProperties properties;
    private AmazonS3 s3Client;


    @Resource
    private ServerConfig serverConfig;

    public S3StoreClient(@Autowired OssProperties ossProperties) {
        properties = ossProperties;
        s3Client = AmazonS3ClientBuilder.standard()
                .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(properties.getAccessKey(), properties.getSecretKey())))
                .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(
                        properties.getEndpoint(),
                        properties.getRegion()))
                .withPathStyleAccessEnabled(false)
                .withChunkedEncodingDisabled(true)
                .build();
    }


    /**
     * @param relativePath 在桶中的相对路径
     * @param inputStream
     */
    // 上传文件，如果是同名，直接覆盖
    public void uploadFile(String relativePath, InputStream inputStream) {
//        try {
        ObjectMetadata metadata = new ObjectMetadata();
//            metadata.setContentLength(inputStream.available()); // 设置内容长度
        s3Client.putObject(properties.getBucketName(), relativePath, inputStream, metadata);
//        } catch (IOException e) {
//            throw new RuntimeException(e);
//        }
    }

    // 删除文件
    public void deleteFile(String relativePath) {
        DeleteObjectRequest deleteObjectRequest = new DeleteObjectRequest(properties.getBucketName(), relativePath);
        s3Client.deleteObject(deleteObjectRequest);
    }

    // 获取文件地址
    public String getUrl(String relativePath) {
        String resultUrl = serverConfig.getUrl();
        ;
        if (relativePath.startsWith("/")) {
            resultUrl += relativePath;
        } else {
            resultUrl += "/" + relativePath;
        }
        return resultUrl;
    }

    /**
     * 获取文件流
     *
     * @param key
     * @return notice:如果key报错，会抛出AmazonS3Exception异常
     */
    public InputStream getObject(String key) {
        GetObjectRequest getObjectRequest = new GetObjectRequest(properties.getBucketName(), key);
        S3Object s3ClientObject = s3Client.getObject(getObjectRequest);
        return s3ClientObject.getObjectContent();
    }


    /**
     * 去除一个完整url链接中的前缀部分，只保留相对文件路径
     *
     * @param url
     * @return
     */
    public String reomvePreUrl(String url) {
        if (url.contains(serverConfig.getUrl())) {
            return url.replace(serverConfig.getUrl(), "");
        }
        return url;
    }


    /**
     * 从MultipartFile 中获取文件名
     *
     * @param file
     * @return
     */
    public String getFilePath(String prePth, MultipartFile file) {
        String filename = UUID.randomUUID().toString().replace("-", "");
        String originalFilename = file.getOriginalFilename();
        String suffix = originalFilename.substring(originalFilename.lastIndexOf("."));
        filename += suffix;
        return prePth + filename;
    }


    /**
     * 删除列表的方式
     *
     * @param serviceIconList
     */
    public void deleteFileList(List<String> serviceIconList) {
        for (String s : serviceIconList) {
            deleteFile(s);
        }
    }

    public URL getLink(String keyName, HttpMethod method, Date expiration) {
        GeneratePresignedUrlRequest request = new GeneratePresignedUrlRequest(properties.getBucketName(), keyName)
                .withMethod(method)
                .withExpiration(expiration);
        return s3Client.generatePresignedUrl(request);
    }
}
