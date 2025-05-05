#include <cstddef>
#include <cstdio>
#include <cstdlib>
#include <iostream>
#include <libavutil/error.h>
#include <ostream>
#include <cstring>
#include <string>
#include <sys/types.h>
extern "C"{
#include "libavformat/avformat.h"
}
#include <linux/limits.h>
#include <unistd.h>
void showlog(std::string m){
    std::cout<<m<<std::endl;
}
std::string getExecPath(){
    char buffer[PATH_MAX];
    ssize_t len=readlink("/proc/self/exe",buffer, sizeof(buffer)-1);
    if (len==-1) {
        return "";
    }
    buffer[len]='\0';

    char *pos=strrchr(buffer,'/');
    if (pos!=nullptr) {
        *pos='\0';
    }else {
        return "";
    }
    return std::string(buffer);
}
int main(){
    std::cout<<"xplayer start "<<std::endl;
    AVFormatContext *fctx=NULL;
    std::string filename=getExecPath()+"/data/input.mp4";
    int openresult=avformat_open_input(&fctx,filename.c_str(), NULL, NULL);
    if (openresult<0) {
        showlog("error");
        exit(1); 
    }

    int findstream=avformat_find_stream_info(fctx, nullptr);
    
    
   if (findstream<0) {
        showlog("not found stram");
       exit(1);
   } 
    showlog("success");
    return 0;
}
