//
//  APISelected.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 15/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
enum APISelected : String {
        case News = "/api/get-posts/"
        case Sign_in = "/api/sign-in/"
        case User_info = "/api/user-info/"
        case AddPost = "/api/add-post"
        case Messages = "/api/get-messages/"
        case Get_card_categories = "/api/get-card-categories/"
        case Get_card = "/api/get-cards/"
        case Get_comments = "/api/get-comments/"
        case Change_user_info = "/api/change-user-info"
        case Sign_up = "/api/sign-up/"
        case Add_coments = "/api/add-comment"
        case Send_message = "/api/send-message"
        case View_message = "/api/view-messages"
        case Set_mark = "/api/set-mark"
        case Set_view = "/api/set-view"
        case Get_sub_post = "/api/get-sub-posts"
        case Add_subscribe = "/api/add-subscribe"
        case Del_subscribe = "/api/del-subscribe"
        case Get_map = "/api/get-map"
}
