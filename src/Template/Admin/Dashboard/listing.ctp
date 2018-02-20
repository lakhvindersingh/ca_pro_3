<h1>Manage Users</h1>
      
  <div class="row mtop15">
      <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center">
                <tr valign="top">
                  <td align="left" class="searchbox">
                    <div class="floatleft">
                          <table cellspacing="0" cellpadding="4" border="0">
                          <tr valign="top">
                              <td valign="middle" align="left" ><input type="text" class="input" value="Enter Keyword" onblur="if(this.value == '') this.value = 'Enter Keyword'" onfocus="if(this.value == 'Enter Keyword') this.value = ''" style="width:300px;"></td>
                              <td valign="middle" align="left" ><select class="select" name="Search_Option" style="width:300px;">
                                  <option value="Name">By Name</option>
                                  <option value="Product_Code">By Product Code</option>
                                </select></td>
                              <td valign="middle" align="left"><div class="black_btn2"><span class="upper"><input type="submit" value="Search Products" name=""></span></div></td>
                            </tr>
                        </table>
                    </div>
                    
                    <div class="floatright top5"><a href="add-form.php" class="black_btn"><span>Add New Product</span></a> <a href="#" class="black_btn mleft5"><span>Manage Products</span></a></div>
                    
                  </td>
              </tr>
      </table>
  </div>
    
    
  <div class="row mtop30">
    <table width="100%" cellspacing="0" cellpadding="0" border="0" align="center" class="listing">
      <tr>
        <th width="4%" align="center">S No.</th>
        <th width="30%" align="left"><?php echo $this->Paginator->sort('Profiles.firstname', 'Name', ['direction' => 'desc']); ?></th>
        <th width="30%" align="left"><?php echo $this->Paginator->sort('Users.email', 'Email', ['direction' => 'desc']); ?></th>
        <th width="30%" align="left"><?php echo $this->Paginator->sort('Users.role', 'Role', ['direction' => 'desc']); ?></th>
        <th width="15%" align="left"><?php echo $this->Paginator->sort('Users.created', 'Created On', ['direction' => 'desc']); ?></th>
        <th width="18%" align="center"><?php echo $this->Paginator->sort('Users.is_active', 'Status', ['direction' => 'desc']); ?></th>
        <th width="6%" align="center">Action</th>
        <th width="5%" align="center"><input type="checkbox" class="check_user_all" value="check_all" id="check_all" name="check_all"></th>
      </tr>

      <?php //pr($allUsers); ?>
      <?= $this->Form->create('Users', ['class'=>'admin_user_lising']);?>
      <?php foreach($allUsers as $key=>$user) : ?>
        <tr>
          <td align="center"><?= $key = $key + 1; ?>.</td>
          <td align="left">
            <span class="blue">
              <?= isset($user->profile->firstname) ? $user->profile->firstname : ''?><?= isset($user->profile->lastname) ? '&nbsp;'.$user->profile->lastname : ''?>
            </span>
          </td>
          <td align="left"><?= isset($user->email) ? $user->email : ''?></td>
          <td align="left"><?= isset($user->role) ? ucfirst($user->role) : ''?></td>
          <td align="left"><?= isset($user->created) ? date("d, m Y", strtotime($user->created)) : ''?></td>
          <td align="center"><?= ($user->is_active == 1) ? 'Active' : 'Deactivated'?></td>
          <td align="center" valign="middle" >&nbsp;
            <?= $this->Html->image('edit_icon.gif', ['prefix'=>false, 'url'=>['controller'=>'Dashboard', 'action'=>'edit', base64_encode($user->id), 'prefix'=>'admin']]);?>
          </td>
          <td valign="middle" align="center"><input type="checkbox" value="<?= $user->id ?>" name="user[]" class="check_user_single"></td>
        </tr>
      <?php endforeach; ?>

      
      <tr align="right">
        <td colspan="8" align="left" class="bordernone">
          <div class="floatleft mtop7">
            <div class="pagination">
              <?= $this->element('pagination');?>
            </div>
          </div>
        
          <div class="floatright">
            <div class="floatleft">
              <select name="user_action" class="select user_action">
                  <option value="">Select Action</option>
                  <option value="Delete">Delete</option>
                  <option value="Activate">Activate</option>
                  <option value="Deactivate">Deactivate</option>
                  <!-- <option value="FeatureProduct">Featured Product</option>
                  <option value="NotFeatured">Not Featured</option> -->
              </select>
            </div>
            <div class="floatleft mleft10"><div class="black_btn2"><span class="upper"><input type="submit" value="SUBMIT" name=""></span></div></div>
          </div>
        </td>
      </tr>
      <?= $this->Form->end();?>
    </table>
  </div>

  <script>
    function countSelectedUsers(){
      var singleCheckedCount = 0;
      var totalCount = 0;
      $('.check_user_single').each(function() {
        if($(this).is(':checked')){
          singleCheckedCount = singleCheckedCount + 1;
        }
        totalCount = totalCount + $(this).length;
      });
      var countReturn = [];
      countReturn = {'total':totalCount, 'selected':singleCheckedCount};
      console.log(countReturn);
      return countReturn;
    }

  $(document).on('submit', '.admin_user_lising', function(){
      var $form = $(this);
      var countReturn = countSelectedUsers();
      
      if(countReturn['selected'] > 0){
        
      }else{
        alert('Select atleast one user first.');
        return false;
      }
  });

  /*
  * User select/Check functionality - Contact module
  * Check all checkbox functionality
  */

  $(document).on('click', '.check_user_all', function() {
    var countReturn = countSelectedUsers();
    console.log(countReturn['total']+'_____'+countReturn['selected']);
    checkedCount = 0;
    if($(this).is(':checked')){
      $('.check_user_single').each(function() {
        $(this).prop('checked', true);
        checkedCount = checkedCount + $(this).length;
      });
      $('.selected-user-count').html(checkedCount);
      
    }else{
      $('.check_user_single').each(function() {
        $(this).prop('checked', false);
      });
      $('.selected-user-count').html(0);
      
    }
  });

  // Single check functionality
  $(document).on('click', '.check_user_single', function() {
    var countReturn = countSelectedUsers();
    
    $('.selected-user-count').html(countReturn['selected']);

    if(countReturn['selected'] == countReturn['total']){
      $('.check_user_all').prop('checked', true);
    }else{
      $('.check_user_all').prop('checked', false);
    }
  });
  </script>