<div class="row">
  <div class="floatleft mtop10"><h1>Edit Users</h1></div>
  <div class="floatright">
    <?= $this->Html->link('Back To Manage Users', ['action'=>'listing', 'prefix'=>'admin']);?>
  </div>
  </div>
      
  <div align="center" class="whitebox mtop15">
  <?= $this->Form->create('User', ['type'=>'file']); ?>
    <table cellspacing="0" cellpadding="7" border="0" align="center">
      <tr>
        <td align="left"><strong class="upper">Username</strong></td>
        <td align="left">
          <?php 
          $username = isset($editData->username) ? $editData->username:'';
          if(!empty($username)){ ?>
            <?= $this->Form->input('User.username', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>$username,'readonly' => 'readonly','disabled']);?>
          <?php }else{ ?>
            <?= $this->Form->input('User.username', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>$username]);?>
          <?php } ?>
        
        </td>
      </tr>
      <tr class="upper">
        <td align="left"><strong class="upper">Email</strong></td>
        <td align="left">
          <?= $this->Form->input('User.email', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($editData->email) ? $editData->email: '']);?>
        </td>
      </tr>
      <tr>
        <td align="left"><strong class="upper">Role</strong></td>
        <td align="left">
          <?php $role = ['admin'=>'Admin', 'chef'=>'Chef', 'user'=>'User']; ?>
          <?= $this->Form->input('User.role', ['empty'=>'Select Role', 'options'=>$role, 'default'=>isset($editData->role) ? $editData->role: '', 'label'=>false, 'style'=>'width: 450px;', 'class'=>'select']) ?>
        </td>
      </tr>
      <tr>
        <td align="left"><strong class="upper">Prefix</strong> </td>
        <td align="left">
         <?php $prefix = ['Mr.'=>'Mr.', 'Mrs.'=>'Mrs.', 'Dr.'=>'Dr.']; ?>
          <?= $this->Form->input('User.role', ['empty'=>'Select Prefix', 'options'=>$prefix, 'default'=>isset($editData->profile->prefix) ? $editData->profile->prefix: '', 'label'=>false, 'style'=>'width: 450px;', 'class'=>'select']) ?>

        </td>
      </tr>
       <tr>
        <td align="left"><strong class="upper">First Name</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.firstname', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($editData->profile->firstname) ? $editData->profile->firstname:'']);?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">Last Name</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.lastname', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($editData->profile->lastname) ? $editData->profile->lastname:'']);?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">Phone</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.phone', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input phoneMask','value'=>isset($editData->profile->phone) ? $editData->profile->phone:'']);?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">Address 1</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.address1', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($editData->profile->address1) ? $editData->profile->address1:'']);?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">Address 2</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.address2', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($editData->profile->address2) ? $editData->profile->address2:'']);?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">State</strong> </td>
        <td align="left"><?= $this->Form->input('Profile.state_id', ['empty'=>'Select State', 'options'=>$states, 'default'=>isset($editData->profile->state_id) ? $editData->profile->state_id:"", 'label'=>false, 'style'=>'width: 450px;', 'class'=>'select']) ?></td>
      </tr>
    <tr>
        <td align="left"><strong class="upper">Country</strong> </td>
        <td align="left">
          <?= $this->Form->input('Profile.country_id', ['empty'=>'Select Country', 'options'=>$country, 'default'=>isset($editData->profile->country_id) ? $editData->profile->country_id:"", 'label'=>false, 'style'=>'width: 450px;', 'class'=>'select']) ?>
        </td>
    </tr>
    <tr>
        <td valign="top" align="left"><strong class="upper">Bio</strong> </td>
        <td align="left"> <?= $this->Form->input('Profile.description', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'textarea','value'=>isset($editData->profile->description) ? $editData->profile->description:'']);?></td>
    </tr>
    <!-- <tr>
        <td valign="top" align="left"><strong class="upper">Product Image</strong></td>
        <td align="left"><input type="file" name="Image" size="35" id="Image" class="textbox"></td>
      </tr> -->

      <tr>
        <td align="center">&nbsp;</td>
        <td align="left"><div class="black_btn2">
        <span class="upper">
        <?= $this->Form->hidden('User.id',['value'=>isset($editData->id) ? $editData->id : '']); ?>
      <?= $this->Form->hidden('Profile.id',['value'=>isset($editData->profile->id) ? $editData->profile->id : '']); ?>
          <?= $this->Form->input('Save', ['type'=>'submit', 'class'=>'btn btn-primary blue-btn save', 'value'=>'Save']); ?>
        </span></div></td>
      </tr>
    </table>
    <?= $this->Form->end(); ?>
  </div>
</div>