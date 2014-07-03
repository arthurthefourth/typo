Feature: Create Category
	As an admin
	In order to make posts easier to find
	I want to categorize my posts

Background:
	Given the blog is set up
	And I am logged into the admin panel

Scenario: New Category Page
	When I follow "Categories"
	Then I should be on the new category page
	And I should see "Your category slug"

Scenario: Create Category
	Given I am on the new category page
	When I fill in "category_name" with "My Category"
	And I fill in "category_keywords" with "keyword1 keyword2"
	And I fill in "category_description" with "This is my new category"
	And I press "Save"
	Then I should be on the new category page 

Scenario: Edit Category
	Given I am on the new category page
	And I have created category "General"
	When I follow "General"
	Then the "category_permalink" field should contain "general"

Scenario: Update Category
	Given I am on the new category page
	And I have created category "General"
	When I follow "General"
	And I fill in "category_description" with "Changed Description"
	And I press "Save"
	Then I should see "successfully saved"