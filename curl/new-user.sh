curl -XPOST -H "Content-type: application/json" -d '{
	"username":"quickstart-user",
	"password":"my-password",
	"companyName":"quickstart-company",
	"emailAddress":"quickstart@mail.com"
}' 'https://api.pub1.passkit.io/user/new'