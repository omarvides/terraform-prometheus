package tests

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestAWS(t *testing.T) {
	uniqueID := random.UniqueId()
	terraformOptions := &terraform.Options{
		TerraformDir: "../",
		Vars: map[string]interface{}{
			"ami":           "ami-c0f0c0bf",
			"instance_type": "t2.micro",
			"name":          fmt.Sprintf("test-instance-%s", uniqueID),
			"region":        "us-east-1",
		},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)
}
