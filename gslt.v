import net.http 

fn main(){
	steam_web_api_key := "YOUR_STEAM_WEB_API_KEY"
	get_list(steam_web_api_key)
	generate_gslt(steam_web_api_key, 730, "V") // 730=CSGO
}

fn get_list(key string){
	api_url := "https://api.steampowered.com/IGameServersService/GetAccountList/v1/?key="+key
	res := http.get(api_url) or {
		printf("ERR : %v\n",err)
		panic(err)
	}
	printf("RESPONSE : %s\n",res.text)
}

fn generate_gslt(key string, appid int, memo string){
	api_url := "https://api.steampowered.com/IGameServersService/CreateAccount/v1/?key="+key+"&appid="+appid.str()+"&memo="+memo
	res := http.post(api_url,"json") or {
		printf("ERR : %v\n",err)
		panic(err)
	}
	printf("RESPONSE : %s\n",res.text)
}

// TODO : Delete GSLT...