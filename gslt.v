import net.http 
import json

fn main(){
	steam_web_api_key := ""
	// get_list(steam_web_api_key)
	generate_gslt(steam_web_api_key, 730, "V") // 730=CSGO
}

fn get_list(key string){
	api_url := "https://api.steampowered.com/IGameServersService/GetAccountList/v1/?key="+key
	res := http.get(api_url) or {
		printf("ERR : %v\n",err)
		panic(err)
	}
	printf("LIST : %s\n",res.text)
}

struct GenerateGsltResponse { // {"response":{"steamid":"xxx","login_token":"xxx"}}
	response GsltStruct [json:response]
} 

struct GsltStruct {
	steamid string [json:steamid]
	login_token string [json:login_token]
}

fn generate_gslt(key string, appid int, memo string){
	api_url := "https://api.steampowered.com/IGameServersService/CreateAccount/v1/?key="+key+"&appid="+appid.str()+"&memo="+memo
	res := http.post(api_url,"json") or {
		printf("ERR : %v\n",err)
		return
	}
	// println(res.text)
	gslt := json.decode(GenerateGsltResponse, res.text) or {
		eprintln('Failed to recode JSON...')
		return 
	} 
	println(gslt.response)
}

// TODO : Delete GSLT...