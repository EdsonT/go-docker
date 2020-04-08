package go_docker

import "github.com/gin-gonic/gin"

func main()  {
	gin.ForceConsoleColor()
	router := gin.Default()
	router.GET("/", func(c *gin.Context) {
		c.JSON(200,gin.H{
			"message":"pong",
		})
		
	})
	router.Run("8080")
	
}
