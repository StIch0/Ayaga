//
//  NewsPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 10/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct NewsViewData : ViewData{
    let login : String
    let title : String
    let short : String
    let text  : String
    let date  : String
    let images : [String]
    let docs : [String]
    let audio : [String]
    let video : [String]
    let views : String
    let mark : Int
    let user_mark : Int
    let postId : Int
    let userId : Int
}

class NewsPresenter {
    private let newsService : GeneralDataService
    weak private var newsView: ViewBuild?
  //  weak private var activityIndicator : ActivityIndicatorState?
    init(newsService : GeneralDataService) {
        self.newsService = newsService
    }
    func atachView(view : ViewBuild){
        newsView = view
    }
    func detachView(){
        newsView = nil
    }
    func getNews(parameters: [String: AnyObject]){
        self.newsView?.startLoading()
         newsService.callAPIGetDataRequest(
            api: APISelected.News.rawValue,
            key: "news",
            model: NewsModel(),
            parameters: parameters,
                                   onSuccess: {
                                    (news) in
            self.newsView?.finishLoading()
            if (news.count == 0){
                print("news.count ",news.count )
                //self.newsView?.setEmptyNews()
            }
            else {
                let mapNews  = (news as! [NewsModel]).map {newsMap in
                    return NewsViewData(
                        login: "\(newsMap.userLogin)",
                        title: "\(newsMap.title)",
                        short: "\(newsMap.short)",
                        text: "\(newsMap.text)",
                        date: "\(newsMap.date)",
                        images: newsMap.images,
                        docs: newsMap.images,
                        audio: newsMap.images,
                        video: newsMap.images,
                        views: "\(newsMap.views)",
                        mark: (newsMap.mark),
                        user_mark: (newsMap.user_mark),
                        postId: newsMap.post_id,
                        userId: newsMap.user_id)
                }
                self.newsView?.setData(data: mapNews)
            }
        }, onFailure: {
            (errorMessage) in
            self.newsView?.finishLoading()
        })
    }
    
}

class SubNewsPresenter {
    private let newsService : GeneralDataService
    weak private var newsView: ViewBuild?
    //  weak private var activityIndicator : ActivityIndicatorState?
    init(newsService : GeneralDataService) {
        self.newsService = newsService
    }
    func atachView(view : ViewBuild){
        newsView = view
    }
    func detachView(){
        newsView = nil
    }
    func getNews(parameters: [String: AnyObject]){
        self.newsView?.startLoading()
        newsService.callAPIGetDataRequest(
            api: APISelected.Get_sub_post.rawValue,
            key: "news",
            model: NewsModel(),
            parameters: parameters,
            onSuccess: {
                (news) in
                self.newsView?.finishLoading()
                if (news.count == 0){
                    print("news.count ",news.count )
                    //self.newsView?.setEmptyNews()
                }
                else {
                    let mapNews  = (news as! [NewsModel]).map {newsMap in
                        return NewsViewData(
                            login: "\(newsMap.userLogin)",
                            title: "\(newsMap.title)",
                            short: "\(newsMap.short)",
                            text: "\(newsMap.text)",
                            date: "\(newsMap.date)",
                            images: newsMap.images,
                            docs: newsMap.images,
                            audio: newsMap.images,
                            video: newsMap.images,
                            views: "\(newsMap.views)",
                            mark: (newsMap.mark),
                            user_mark: (newsMap.user_mark),
                            postId: newsMap.post_id,
                            userId: newsMap.user_id)
                    }
                    self.newsView?.setData(data: mapNews)
                }
        }, onFailure: {
            (errorMessage) in
            self.newsView?.finishLoading()
        })
    }
    
}
