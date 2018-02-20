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
        <td align="left"><strong class="upper">Name</strong> </td>
        <td align="left"><?= $this->Form->input('Cuisines.name', ['label'=>false, 'style'=>'width: 450px;', 'class'=>'input','value'=>isset($cuisine->name) ? $cuisine->name:'']);?></td>
      </tr>
      
         <tr>
        <td align="left"><strong class="upper">Status</strong> </td>
        <td align="left"><?php $role = ['0'=>'Deactive', '1'=>'Active']; ?>
          <?= $this->Form->input('Cuisines.is_active', ['empty'=>'Status', 'options'=>$role, 'default'=>isset($cuisine->is_active) ? $cuisine->is_active: '', 'label'=>false, 'style'=>'width: 450px;', 'class'=>'select']) ?></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="left"><div class="black_btn2">
        <span class="upper">
        <?= $this->Form->hidden('Cuisines.id',['value'=>isset($cuisine->id) ? $cuisine->id : '']); ?>
        <?= $this->Form->input('Update', ['type'=>'submit', 'class'=>'btn btn-primary blue-btn save', 'value'=>'Save']); ?>
        </span></div></td>
      </tr>
    </table>
    <?= $this->Form->end(); ?>
  </div>
</div>