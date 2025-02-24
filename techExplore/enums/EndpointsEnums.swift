//
//  EndpointsEnums.swift
//  techExplore
//
//  Created by Despo on 19.02.25.
//

enum EndpointsEnums: String {
  case token = "http://k8s-developm-djangoba-3689330442-e7183bfee2f06c11.elb.eu-central-1.amazonaws.com:8000/user/token/refresh/"
  case login = "http://k8s-developm-djangoba-3689330442-e7183bfee2f06c11.elb.eu-central-1.amazonaws.com:8000/user/login/"
  case transactions = "http://k8s-developm-djangoba-3689330442-e7183bfee2f06c11.elb.eu-central-1.amazonaws.com:8000/transaction/listing/"
  case singleCard = "http://k8s-developm-djangoba-3689330442-e7183bfee2f06c11.elb.eu-central-1.amazonaws.com:8000/cards/retrieve/b5f3bde4-7633-4222-8e8c-bcd1ce8449ca/"
}
